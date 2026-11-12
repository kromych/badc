
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
               	sub	sp, sp, #0x20
               	sturb	wzr, [x29, #-0x20]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x1f]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x1e]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x1d]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x1c]
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x1b]
               	mov	x0, #0x6                // =6
               	sturb	w0, [x29, #-0x1a]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x19]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x18]
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0x17]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x16]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0x15]
               	mov	x1, #0xc                // =12
               	sturb	w1, [x29, #-0x14]
               	mov	x1, #0xd                // =13
               	sturb	w1, [x29, #-0x13]
               	mov	x1, #0xe                // =14
               	sturb	w1, [x29, #-0x12]
               	mov	x1, #0xf                // =15
               	sturb	w1, [x29, #-0x11]
               	dup	v0.16b, w0
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	ldur	q1, [x29, #-0x20]
               	add	v1.16b, v1.16b, v0.16b
               	stur	q1, [x29, #-0x10]
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
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	ldur	q1, [x29, #-0x20]
               	add	v1.16b, v1.16b, v0.16b
               	stur	q1, [x29, #-0x10]
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
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x20
               	ldur	q1, [x29, #-0x20]
               	add	v1.16b, v1.16b, v0.16b
               	mov	v16.16b, v1.16b
               	add	v16.16b, v16.16b, v0.16b
               	mov	v0.16b, v16.16b
               	stur	q0, [x29, #-0x10]
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
