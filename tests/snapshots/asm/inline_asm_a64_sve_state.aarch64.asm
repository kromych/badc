
inline_asm_a64_sve_state.aarch64:	file format elf64-littleaarch64

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

<sve_save_z>:
               	str	z0, [x0]
               	str	z1, [x0, #0x1, mul vl]
               	str	z2, [x0, #0x2, mul vl]
               	str	z3, [x0, #0x3, mul vl]
               	str	z4, [x0, #0x4, mul vl]
               	str	z5, [x0, #0x5, mul vl]
               	str	z6, [x0, #0x6, mul vl]
               	str	z7, [x0, #0x7, mul vl]
               	str	z8, [x0, #0x8, mul vl]
               	str	z9, [x0, #0x9, mul vl]
               	str	z10, [x0, #0xa, mul vl]
               	str	z11, [x0, #0xb, mul vl]
               	str	z12, [x0, #0xc, mul vl]
               	str	z13, [x0, #0xd, mul vl]
               	str	z14, [x0, #0xe, mul vl]
               	str	z15, [x0, #0xf, mul vl]
               	str	z16, [x0, #0x10, mul vl]
               	str	z17, [x0, #0x11, mul vl]
               	str	z18, [x0, #0x12, mul vl]
               	str	z19, [x0, #0x13, mul vl]
               	str	z20, [x0, #0x14, mul vl]
               	str	z21, [x0, #0x15, mul vl]
               	str	z22, [x0, #0x16, mul vl]
               	str	z23, [x0, #0x17, mul vl]
               	str	z24, [x0, #0x18, mul vl]
               	str	z25, [x0, #0x19, mul vl]
               	str	z26, [x0, #0x1a, mul vl]
               	str	z27, [x0, #0x1b, mul vl]
               	str	z28, [x0, #0x1c, mul vl]
               	str	z29, [x0, #0x1d, mul vl]
               	str	z30, [x0, #0x1e, mul vl]
               	str	z31, [x0, #0x1f, mul vl]
               	ret

<sve_save_p>:
               	str	p0, [x0]
               	str	p1, [x0, #0x1, mul vl]
               	str	p2, [x0, #0x2, mul vl]
               	str	p3, [x0, #0x3, mul vl]
               	str	p4, [x0, #0x4, mul vl]
               	str	p5, [x0, #0x5, mul vl]
               	str	p6, [x0, #0x6, mul vl]
               	str	p7, [x0, #0x7, mul vl]
               	str	p8, [x0, #0x8, mul vl]
               	str	p9, [x0, #0x9, mul vl]
               	str	p10, [x0, #0xa, mul vl]
               	str	p11, [x0, #0xb, mul vl]
               	str	p12, [x0, #0xc, mul vl]
               	str	p13, [x0, #0xd, mul vl]
               	str	p14, [x0, #0xe, mul vl]
               	str	p15, [x0, #0xf, mul vl]
               	rdffr	p0.b
               	str	p0, [x1]
               	ldr	p0, [x0]
               	ret

<sve_flush_p>:
               	pfalse	p0.b
               	pfalse	p1.b
               	pfalse	p2.b
               	pfalse	p3.b
               	pfalse	p4.b
               	pfalse	p5.b
               	pfalse	p6.b
               	pfalse	p7.b
               	pfalse	p8.b
               	pfalse	p9.b
               	pfalse	p10.b
               	pfalse	p11.b
               	pfalse	p12.b
               	pfalse	p13.b
               	pfalse	p14.b
               	pfalse	p15.b
               	wrffr	p0.b
               	ret

<sme_get_vl>:
               	rdsvl	x0, #0x1
               	ret

<sme_save_za>:
               	mov	x9, #0x0                // =0
               	mov	w9, w9
               	cmp	x9, x1
               	b.hs	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	mov	x2, #0x0                // =0
               	mov	w12, w2
               	madd	x0, x12, x1, x3
               	str	x12, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x12, [sp]
               	ldr	x0, [sp, #0x8]
               	str	za[w12, 0], [x0]
               	add	x2, x2, #0x1
               	mov	w12, w2
               	cmp	x12, x1
               	b.lo	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ret

<sve_words>:
               	ldr	z0, [x0]
               	ldr	z31, [x1, #0x1f, mul vl]
               	ldr	z5, [sp, #-0x100, mul vl]
               	str	z1, [x2, #0xff, mul vl]
               	ldr	p15, [x1, #0xf, mul vl]
               	str	p3, [x2, #-0x100, mul vl]
               	str	p0, [x0]
               	rdffr	p15.b
               	wrffr	p15.b
               	pfalse	p0.b
               	rdsvl	x30, #-0x20
               	ldr	za[w15, 15], [x1, #0xf, mul vl]
               	str	za[w13, 3], [sp, #0x3, mul vl]
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldr	w2, [x1]
               	mov	x17, #0x4000            // =16384
               	movk	x17, #0x8580, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	ret
               	mov	x2, #0x1                // =1
               	ldr	w3, [x1, #0x4]
               	mov	x17, #0x5c3f            // =23615
               	movk	x17, #0x8583, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x2                // =2
               	ldr	w3, [x1, #0x8]
               	mov	x17, #0x43e5            // =17381
               	movk	x17, #0x85a0, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x3                // =3
               	ldr	w3, [x1, #0xc]
               	mov	x17, #0x5c41            // =23617
               	movk	x17, #0xe59f, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x4                // =4
               	ldr	w3, [x1, #0x10]
               	mov	x17, #0x1c2f            // =7215
               	movk	x17, #0x8581, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x5                // =5
               	ldr	w3, [x1, #0x14]
               	mov	x17, #0x43              // =67
               	movk	x17, #0xe5a0, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x6                // =6
               	ldr	w3, [x1, #0x18]
               	mov	x17, #0xe5800000        // =3850371072
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x7                // =7
               	ldr	w3, [x1, #0x1c]
               	mov	x17, #0xf00f            // =61455
               	movk	x17, #0x2519, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x8                // =8
               	ldr	w3, [x1, #0x20]
               	mov	x17, #0x91e0            // =37344
               	movk	x17, #0x2528, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x9                // =9
               	ldr	w3, [x1, #0x24]
               	mov	x17, #0xe400            // =58368
               	movk	x17, #0x2518, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xa                // =10
               	ldr	w3, [x1, #0x28]
               	mov	x17, #0x5c1e            // =23582
               	movk	x17, #0x4bf, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xb                // =11
               	ldr	w3, [x1, #0x2c]
               	mov	x17, #0x602f            // =24623
               	movk	x17, #0xe100, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xc                // =12
               	ldr	w1, [x1, #0x30]
               	mov	x17, #0x23e3            // =9187
               	movk	x17, #0xe120, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	ret
