
inline_asm_a64_vector_w.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x1403             // =5123
               	mov	x1, #0xeff0             // =61424
               	sturh	w0, [x29, #-0x30]
               	sturh	w1, [x29, #-0x20]
               	mov	x0, #0x3625             // =13861
               	mov	x1, #0xedee             // =60910
               	sturh	w0, [x29, #-0x2e]
               	sturh	w1, [x29, #-0x1e]
               	mov	x0, #0x5847             // =22599
               	mov	x1, #0xebec             // =60396
               	sturh	w0, [x29, #-0x2c]
               	sturh	w1, [x29, #-0x1c]
               	mov	x0, #0x7a69             // =31337
               	mov	x1, #0xe9ea             // =59882
               	sturh	w0, [x29, #-0x2a]
               	sturh	w1, [x29, #-0x1a]
               	mov	x0, #0x9c8b             // =40075
               	mov	x1, #0xe7e8             // =59368
               	sturh	w0, [x29, #-0x28]
               	sturh	w1, [x29, #-0x18]
               	mov	x0, #0xbead             // =48813
               	mov	x2, #0xe5e6             // =58854
               	sub	x1, x29, #0x30
               	sturh	w0, [x29, #-0x26]
               	sturh	w2, [x29, #-0x16]
               	mov	x0, #0xe0cf             // =57551
               	mov	x2, #0xe3e4             // =58340
               	sturh	w0, [x29, #-0x24]
               	sturh	w2, [x29, #-0x14]
               	mov	x0, #0x2f1              // =753
               	mov	x2, #0xe1e2             // =57826
               	sturh	w0, [x29, #-0x22]
               	sturh	w2, [x29, #-0x12]
               	sub	x16, x29, #0x30
               	ldr	q0, [x16]
               	sub	x2, x29, #0x20
               	sub	x16, x29, #0x20
               	ldr	q1, [x16]
               	sub	x3, x29, #0x10
               	eor	v2.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x10
               	str	q2, [x16]
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
               	sub	x2, x29, #0x10
               	mov	x16, #0xa5              // =165
               	dup	v2.16b, w16
               	eor3	v1.16b, v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa5               // =165
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x1, x0]
               	sub	x6, x29, #0x20
               	ldrb	w6, [x6, x0]
               	eor	x5, x5, x6
               	eor	x5, x5, x3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0xf                // =15
               	mov	x0, #0xe0f              // =3599
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0xc0d              // =3085
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0xa0b              // =2571
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x809              // =2057
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x607              // =1543
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x405              // =1029
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x203              // =515
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x2]
               	sub	x16, x29, #0x10
               	ldr	q1, [x16]
               	tbl	v1.16b, { v0.16b }, v1.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	sub	x4, x29, #0x30
               	sub	x5, x2, x0
               	ldrb	w4, [x4, x5]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x16, #0x13              // =19
               	dup	v1.16b, w16
               	mov	x16, #0x11              // =17
               	dup	v2.16b, w16
               	pmul	v1.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	sub	x3, x29, #0x10
               	ldurb	w0, [x29, #-0x10]
               	cmp	w0, #0x23
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	dup	v1.16b, w16
               	sshr	v2.16b, v0.16b, #0x7
               	shl	v0.16b, v0.16b, #0x1
               	and	v1.16b, v2.16b, v1.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x2, x29, #0x30
               	ldrb	w2, [x2, x0]
               	tst	x2, #0x80
               	csel	x5, x4, x1, ne
               	eor	x2, x5, x2, lsl #1
               	and	x2, x2, #0xff
               	ldrb	w5, [x3, x0]
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
