
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
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x16, x29, #0x40
               	str	q1, [x16]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x40
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
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

<add_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x16, x29, #0x60
               	str	q1, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x60
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	ldr	x16, [sp, #0x30]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x50
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	sub	x0, x29, #0x90
               	add	x1, x0, #0x0
               	mov	x2, #0x0                // =0
               	strb	w2, [x1]
               	sub	x1, x29, #0x80
               	add	x3, x1, #0x0
               	mov	x2, #0xa                // =10
               	strb	w2, [x3]
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
               	sub	x0, x29, #0x80
               	mov	x2, #0xa                // =10
               	strb	w2, [x0, #0x7]
               	sub	x1, x29, #0x90
               	mov	x3, #0x8                // =8
               	strb	w3, [x1, #0x8]
               	strb	w2, [x0, #0x8]
               	mov	x3, #0x9                // =9
               	strb	w3, [x1, #0x9]
               	strb	w2, [x0, #0x9]
               	strb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	mov	x3, #0xb                // =11
               	strb	w3, [x1, #0xb]
               	strb	w2, [x0, #0xb]
               	mov	x3, #0xc                // =12
               	strb	w3, [x1, #0xc]
               	strb	w2, [x0, #0xc]
               	mov	x3, #0xd                // =13
               	strb	w3, [x1, #0xd]
               	strb	w2, [x0, #0xd]
               	mov	x0, #0xe                // =14
               	strb	w0, [x1, #0xe]
               	sub	x1, x29, #0x80
               	mov	x0, #0xa                // =10
               	strb	w0, [x1, #0xe]
               	sub	x20, x29, #0x90
               	mov	x2, #0xf                // =15
               	strb	w2, [x20, #0xf]
               	strb	w0, [x1, #0xf]
               	sub	x21, x29, #0x70
               	ldr	q0, [x20]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x21, x1
               	ldrb	w4, [x2]
               	add	x2, x1, #0xa
               	and	x2, x2, x3
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x2, x20, x1
               	ldrb	w2, [x2]
               	and	x4, x1, x3
               	cmp	w2, w4
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x70
               	sub	x21, x29, #0x90
               	sub	x1, x29, #0x80
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w4, [x2]
               	add	x2, x1, #0xa
               	and	x2, x2, x3
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x2, x21, x1
               	ldrb	w2, [x2]
               	and	x4, x1, x3
               	cmp	w2, w4
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x70
               	sub	x21, x29, #0x90
               	sub	x1, x29, #0x80
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x80
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w4, [x2]
               	add	x2, x1, #0x14
               	and	x2, x2, x3
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x2, x21, x1
               	ldrb	w2, [x2]
               	and	x4, x1, x3
               	cmp	w2, w4
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
