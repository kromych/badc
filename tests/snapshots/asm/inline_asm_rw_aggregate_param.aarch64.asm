
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x50
               	strb	wzr, [x0]
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	mov	x0, #0xa                // =10
               	strb	w0, [x1, #0x7]
               	sub	x2, x29, #0x50
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
               	sub	x0, x29, #0x40
               	mov	x2, #0xa                // =10
               	strb	w2, [x0, #0xe]
               	sub	x1, x29, #0x50
               	mov	x3, #0xf                // =15
               	strb	w3, [x1, #0xf]
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x30
               	ldr	q0, [x1]
               	ldr	q1, [x0]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
               	add	v0.16b, v0.16b, v1.16b
               	str	q0, [x2]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	add	x4, x0, #0xa
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x1, x0]
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x50
               	ldr	q0, [x2]
               	ldur	q1, [x29, #-0x40]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
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
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x50
               	ldr	q0, [x2]
               	ldur	q1, [x29, #-0x40]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
               	add	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x40]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
               	add	v0.16b, v0.16b, v1.16b
               	str	q0, [x1]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	add	x4, x0, #0x14
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, x0]
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
