
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
               	sturb	wzr, [x29, #-0x50]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x40]
               	mov	x1, #0x1                // =1
               	sturb	w1, [x29, #-0x4f]
               	sturb	w0, [x29, #-0x3f]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x4e]
               	sturb	w0, [x29, #-0x3e]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x4d]
               	sturb	w0, [x29, #-0x3d]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x4c]
               	sturb	w0, [x29, #-0x3c]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x4b]
               	sturb	w0, [x29, #-0x3b]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x4a]
               	sturb	w0, [x29, #-0x3a]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x49]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x39]
               	mov	x1, #0x8                // =8
               	sturb	w1, [x29, #-0x48]
               	sturb	w0, [x29, #-0x38]
               	mov	x1, #0x9                // =9
               	sturb	w1, [x29, #-0x47]
               	sturb	w0, [x29, #-0x37]
               	sturb	w0, [x29, #-0x46]
               	sturb	w0, [x29, #-0x36]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0x45]
               	sturb	w0, [x29, #-0x35]
               	mov	x1, #0xc                // =12
               	sturb	w1, [x29, #-0x44]
               	sturb	w0, [x29, #-0x34]
               	mov	x1, #0xd                // =13
               	sturb	w1, [x29, #-0x43]
               	sturb	w0, [x29, #-0x33]
               	mov	x0, #0xe                // =14
               	sturb	w0, [x29, #-0x42]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x32]
               	sub	x1, x29, #0x50
               	mov	x2, #0xf                // =15
               	sturb	w2, [x29, #-0x41]
               	sturb	w0, [x29, #-0x31]
               	sub	x2, x29, #0x30
               	ldur	q0, [x29, #-0x50]
               	ldur	q1, [x29, #-0x40]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
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
               	ldur	q0, [x29, #-0x50]
               	ldur	q1, [x29, #-0x40]
               	str	q0, [sp, #0x30]
               	str	q1, [sp, #0x40]
               	ldr	q0, [sp, #0x30]
               	ldr	q1, [sp, #0x40]
               	add	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
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
               	ldur	q0, [x29, #-0x50]
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
               	stur	q0, [x29, #-0x30]
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
