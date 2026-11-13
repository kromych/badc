
gcc_vector_bitwise_ops.aarch64:	file format elf64-littleaarch64

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

<same16>:
               	umov	w1, v0.b[0]
               	ldrb	w2, [x0]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	umov	w1, v0.b[1]
               	ldrb	w2, [x0, #0x1]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[2]
               	ldrb	w2, [x0, #0x2]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[3]
               	ldrb	w2, [x0, #0x3]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[4]
               	ldrb	w2, [x0, #0x4]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[5]
               	ldrb	w2, [x0, #0x5]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[6]
               	ldrb	w2, [x0, #0x6]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[7]
               	ldrb	w2, [x0, #0x7]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[8]
               	ldrb	w2, [x0, #0x8]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[9]
               	ldrb	w2, [x0, #0x9]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[10]
               	ldrb	w2, [x0, #0xa]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[11]
               	ldrb	w2, [x0, #0xb]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[12]
               	ldrb	w2, [x0, #0xc]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[13]
               	ldrb	w2, [x0, #0xd]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[14]
               	ldrb	w2, [x0, #0xe]
               	cmp	x1, x2
               	b.ne	<addr>
               	umov	w1, v0.b[15]
               	ldrb	w0, [x0, #0xf]
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x1, x29, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x30
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	eor	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x20
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	and	x4, x4, x5
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x10
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	orr	x4, x4, x5
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	and	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	orr	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q1, [x29, #-0x80]
               	ldur	q0, [x29, #-0x70]
               	eor	v1.16b, v1.16b, v0.16b
               	eor	v0.16b, v1.16b, v0.16b
               	sub	x7, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	sub	x7, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	sub	x0, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	and	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	sub	x0, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	orr	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x0, #0x2fe              // =766
               	movk	x0, #0x4fc, lsl #16
               	movk	x0, #0x6fa, lsl #32
               	movk	x0, #0x8f8, lsl #48
               	stur	x0, [x29, #-0x38]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x31]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x70
               	mov	x0, #0x801              // =2049
               	mov	x3, #0xc7c8             // =51144
               	sturh	w0, [x29, #-0x50]
               	sturh	w3, [x29, #-0x70]
               	mov	x0, #0x160f             // =5647
               	mov	x3, #0xc5c6             // =50630
               	sturh	w0, [x29, #-0x4e]
               	sturh	w3, [x29, #-0x6e]
               	mov	x0, #0x241d             // =9245
               	mov	x3, #0xc3c4             // =50116
               	sturh	w0, [x29, #-0x4c]
               	sturh	w3, [x29, #-0x6c]
               	mov	x0, #0x322b             // =12843
               	mov	x3, #0xc1c2             // =49602
               	sturh	w0, [x29, #-0x4a]
               	sturh	w3, [x29, #-0x6a]
               	mov	x0, #0x4039             // =16441
               	mov	x3, #0xbfc0             // =49088
               	sturh	w0, [x29, #-0x48]
               	sturh	w3, [x29, #-0x68]
               	mov	x0, #0x4e47             // =20039
               	mov	x3, #0xbdbe             // =48574
               	sturh	w0, [x29, #-0x46]
               	sturh	w3, [x29, #-0x66]
               	mov	x0, #0x5c55             // =23637
               	mov	x3, #0xbbbc             // =48060
               	sturh	w0, [x29, #-0x44]
               	sturh	w3, [x29, #-0x64]
               	mov	x0, #0x6a63             // =27235
               	mov	x3, #0xb9ba             // =47546
               	sturh	w0, [x29, #-0x42]
               	sturh	w3, [x29, #-0x62]
               	sub	x3, x29, #0x60
               	ldur	q0, [x29, #-0x50]
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	eor	x5, x5, x6
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
