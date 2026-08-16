
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
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	sub	x0, x29, #0x90
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0]
               	sub	x0, x29, #0x90
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x90
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x90
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x90
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x90
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x90
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x90
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x90
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x90
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x90
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x90
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x90
               	mov	x1, #0xc                // =12
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x90
               	mov	x1, #0xd                // =13
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x90
               	mov	x1, #0xe                // =14
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x90
               	mov	x1, #0xf                // =15
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xa0
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xf]
               	sub	x20, x29, #0xb0
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0xa0
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xb0
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	add	x2, x1, #0xa
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x90
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	cmp	x2, x3
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xb0
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0xa0
               	sub	x3, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x30
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x16, [sp, #0x10]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x58
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xb0
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	add	x2, x1, #0xa
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x90
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	cmp	x2, x3
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0xb0
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x30
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x16, [sp, #0x10]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	add	v0.16b, v0.16b, v1.16b
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x70
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xb0
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	add	x2, x1, #0x14
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x90
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	cmp	x2, x3
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
