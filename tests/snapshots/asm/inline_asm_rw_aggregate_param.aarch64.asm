
inline_asm_rw_aggregate_param.aarch64:	file format elf64-littleaarch64

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

<add_param>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x20]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x28]
               	ldr	x16, [sp, #0x20]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	sub	x0, x29, #0x50
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	sub	x0, x29, #0xd0
               	strb	wzr, [x0]
               	sub	x1, x29, #0xc0
               	mov	x2, #0xa                // =10
               	strb	w2, [x1]
               	mov	x3, #0x1                // =1
               	strb	w3, [x0, #0x1]
               	strb	w2, [x1, #0x1]
               	mov	x3, #0x2                // =2
               	strb	w3, [x0, #0x2]
               	strb	w2, [x1, #0x2]
               	mov	x3, #0x3                // =3
               	strb	w3, [x0, #0x3]
               	strb	w2, [x1, #0x3]
               	mov	x3, #0x4                // =4
               	strb	w3, [x0, #0x4]
               	strb	w2, [x1, #0x4]
               	mov	x3, #0x5                // =5
               	strb	w3, [x0, #0x5]
               	strb	w2, [x1, #0x5]
               	mov	x3, #0x6                // =6
               	strb	w3, [x0, #0x6]
               	strb	w2, [x1, #0x6]
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0xc0
               	mov	x0, #0xa                // =10
               	strb	w0, [x1, #0x7]
               	sub	x2, x29, #0xd0
               	mov	x3, #0x8                // =8
               	strb	w3, [x2, #0x8]
               	strb	w0, [x1, #0x8]
               	mov	x3, #0x9                // =9
               	strb	w3, [x2, #0x9]
               	strb	w0, [x1, #0x9]
               	strb	w0, [x2, #0xa]
               	strb	w0, [x1, #0xa]
               	mov	x3, #0xb                // =11
               	strb	w3, [x2, #0xb]
               	strb	w0, [x1, #0xb]
               	mov	x3, #0xc                // =12
               	strb	w3, [x2, #0xc]
               	strb	w0, [x1, #0xc]
               	mov	x3, #0xd                // =13
               	strb	w3, [x2, #0xd]
               	strb	w0, [x1, #0xd]
               	mov	x0, #0xe                // =14
               	strb	w0, [x2, #0xe]
               	sub	x7, x29, #0xc0
               	mov	x0, #0xa                // =10
               	strb	w0, [x7, #0xe]
               	sub	x20, x29, #0xd0
               	mov	x1, #0xf                // =15
               	strb	w1, [x20, #0xf]
               	strb	w0, [x7, #0xf]
               	sub	x21, x29, #0xb0
               	ldr	q0, [x20]
               	ldr	q1, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x21, x0]
               	add	x2, x0, #0xa
               	cmp	w1, w2
               	b.ne	<addr>
               	ldrb	w1, [x20, x0]
               	cmp	w1, w0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xb0
               	sub	x2, x29, #0xd0
               	ldr	q0, [x2]
               	str	q0, [sp, #0x70]
               	sub	x16, x29, #0xc0
               	str	x16, [sp, #0x80]
               	ldr	q0, [sp, #0x70]
               	ldr	x16, [sp, #0x80]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	str	q0, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	add	x4, x0, #0xa
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, x0]
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0xb0
               	sub	x21, x29, #0xd0
               	ldr	q0, [x21]
               	str	q0, [sp, #0x70]
               	sub	x16, x29, #0xc0
               	str	x16, [sp, #0x80]
               	ldr	q0, [sp, #0x70]
               	ldr	x16, [sp, #0x80]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0x50
               	str	q0, [x7]
               	sub	x0, x29, #0xc0
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x20, x0]
               	add	x2, x0, #0x14
               	cmp	w1, w2
               	b.ne	<addr>
               	ldrb	w1, [x21, x0]
               	cmp	w1, w0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xe0]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldp	x20, x21, [sp], #0xf0
               	ret
