
vector_abi_variadic.aarch64:	file format elf64-littleaarch64

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

<lane_sum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x3
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x1, x0
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrb	w4, [x2]
               	ldrb	w2, [x2, #0xf]
               	add	x2, x4, x2
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<lane_sum8>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x3
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x1, x0
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrb	w4, [x2]
               	ldrb	w2, [x2, #0x7]
               	add	x2, x4, x2
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<interleaved>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	d1, [x3]
               	sub	x3, x29, #0x20
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrb	w3, [x3, #0x3]
               	scvtf	d2, x2
               	fadd	d1, d2, d1
               	scvtf	d2, x3
               	fadd	d1, d1, d2
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<bank_edge>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrb	w3, [x2]
               	ldrb	w2, [x2, #0x7]
               	add	x2, x3, x2
               	scvtf	d2, x2
               	fadd	d1, d1, d2
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<ramp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	and	x1, x0, #0xff
               	sturb	w1, [x29, #-0x10]
               	add	x2, x1, #0x1
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xf]
               	add	x2, x1, #0x2
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xe]
               	add	x2, x1, #0x3
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xd]
               	add	x2, x1, #0x4
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xc]
               	add	x2, x1, #0x5
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xb]
               	add	x2, x1, #0x6
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0xa]
               	add	x2, x1, #0x7
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x9]
               	add	x2, x1, #0x8
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x8]
               	add	x2, x1, #0x9
               	and	x2, x2, #0xff
               	sturb	w2, [x29, #-0x7]
               	sub	x2, x29, #0x10
               	add	x3, x1, #0xa
               	and	x3, x3, #0xff
               	sturb	w3, [x29, #-0x6]
               	add	x1, x1, #0xb
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x5]
               	and	x1, x0, #0xff
               	add	x0, x1, #0xc
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4]
               	add	x0, x1, #0xd
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x3]
               	add	x0, x1, #0xe
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x2]
               	add	x0, x1, #0xf
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x1]
               	mov	x16, x2
               	ldr	q0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	d8, [sp, #0x20]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0xe0]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	q0, [x29, #-0xd0]
               	sub	x7, x29, #0xd0
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0xe0
               	ldr	q0, [x1]
               	ldr	q1, [x7]
               	bl	<addr>
               	cmp	w0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0xc0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	stur	q0, [x29, #-0xb0]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	q0, [x29, #-0xa0]
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	stur	q0, [x29, #-0x90]
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	stur	q0, [x29, #-0x60]
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	stur	q0, [x29, #-0x50]
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	stur	q0, [x29, #-0xe0]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0xd0]
               	sub	x7, x29, #0xd0
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0xc0
               	sub	x2, x29, #0xb0
               	sub	x3, x29, #0xa0
               	sub	x4, x29, #0x90
               	sub	x5, x29, #0x80
               	sub	x6, x29, #0x70
               	sub	x8, x29, #0x60
               	sub	x9, x29, #0x50
               	sub	x10, x29, #0xe0
               	mov	x16, x10
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x3]
               	ldr	q3, [x4]
               	ldr	q4, [x5]
               	ldr	q5, [x6]
               	ldr	q6, [x8]
               	ldr	q7, [x9]
               	bl	<addr>
               	cmp	w0, #0x104
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x8
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x6                // =6
               	sturb	w0, [x29, #-0x7]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x6]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x5]
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0x4]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0x2]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0x1]
               	mov	x0, #0x1                // =1
               	ldr	d0, [x7]
               	bl	<addr>
               	cmp	w0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0xe0]
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	stur	q0, [x29, #-0xd0]
               	sub	x7, x29, #0xd0
               	mov	x0, #0x2                // =2
               	mov	x1, #0x7                // =7
               	fmov	d0, #0.50000000
               	sub	x3, x29, #0xe0
               	mov	x2, #0x9                // =9
               	fmov	d1, #0.25000000
               	fmov	d2, d1
               	ldr	q1, [x3]
               	ldr	q3, [x7]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	movi	d1, #0000000000000000
               	mov	x2, #0x1                // =1
               	scvtf	d2, x2
               	fmov	d0, #4.00000000
               	fdiv	d2, d2, d0
               	mov	x0, #0x9                // =9
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x1, #0x2                // =2
               	scvtf	d2, x1
               	fdiv	d2, d2, d0
               	mov	x0, #0xb                // =11
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x3, #0x3                // =3
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	mov	x0, #0xd                // =13
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x4, #0x4                // =4
               	scvtf	d2, x4
               	fdiv	d2, d2, d0
               	mov	x0, #0xf                // =15
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x5, #0x5                // =5
               	scvtf	d2, x5
               	fdiv	d2, d2, d0
               	mov	x0, #0x11               // =17
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x0, #0x6                // =6
               	scvtf	d2, x0
               	fdiv	d0, d2, d0
               	mov	x6, #0x13               // =19
               	scvtf	d2, x6
               	fadd	d0, d0, d2
               	fadd	d8, d1, d0
               	fmov	d0, #0.25000000
               	sturb	w2, [x29, #-0x8]
               	sturb	w1, [x29, #-0x7]
               	sturb	w3, [x29, #-0x6]
               	sturb	w4, [x29, #-0x5]
               	sturb	w5, [x29, #-0x4]
               	sturb	w0, [x29, #-0x3]
               	mov	x2, #0x7                // =7
               	sturb	w2, [x29, #-0x2]
               	mov	x3, #0x8                // =8
               	sturb	w3, [x29, #-0x1]
               	sub	x7, x29, #0x40
               	ldur	x4, [x29, #-0x8]
               	stur	x4, [x29, #-0x40]
               	fmov	d1, #0.50000000
               	sturb	w1, [x29, #-0x8]
               	mov	x4, #0x3                // =3
               	sturb	w4, [x29, #-0x7]
               	mov	x5, #0x4                // =4
               	sturb	w5, [x29, #-0x6]
               	mov	x6, #0x5                // =5
               	sturb	w6, [x29, #-0x5]
               	mov	x8, #0x6                // =6
               	sturb	w8, [x29, #-0x4]
               	sturb	w2, [x29, #-0x3]
               	sturb	w3, [x29, #-0x2]
               	mov	x1, #0x9                // =9
               	sturb	w1, [x29, #-0x1]
               	sub	x9, x29, #0x38
               	ldur	x2, [x29, #-0x8]
               	stur	x2, [x29, #-0x38]
               	fmov	d2, #0.75000000
               	sturb	w4, [x29, #-0x8]
               	sturb	w5, [x29, #-0x7]
               	sturb	w6, [x29, #-0x6]
               	sturb	w8, [x29, #-0x5]
               	mov	x2, #0x7                // =7
               	sturb	w2, [x29, #-0x4]
               	mov	x3, #0x8                // =8
               	sturb	w3, [x29, #-0x3]
               	sturb	w1, [x29, #-0x2]
               	mov	x4, #0xa                // =10
               	sturb	w4, [x29, #-0x1]
               	sub	x8, x29, #0x30
               	ldur	x5, [x29, #-0x8]
               	stur	x5, [x29, #-0x30]
               	fmov	d3, #1.00000000
               	mov	x5, #0x4                // =4
               	sturb	w5, [x29, #-0x8]
               	mov	x5, #0x5                // =5
               	sturb	w5, [x29, #-0x7]
               	mov	x6, #0x6                // =6
               	sturb	w6, [x29, #-0x6]
               	sturb	w2, [x29, #-0x5]
               	sturb	w3, [x29, #-0x4]
               	sturb	w1, [x29, #-0x3]
               	sturb	w4, [x29, #-0x2]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0x1]
               	sub	x4, x29, #0x28
               	ldur	x2, [x29, #-0x8]
               	stur	x2, [x29, #-0x28]
               	fmov	d4, #1.25000000
               	sturb	w5, [x29, #-0x8]
               	sturb	w6, [x29, #-0x7]
               	mov	x2, #0x7                // =7
               	sturb	w2, [x29, #-0x6]
               	mov	x3, #0x8                // =8
               	sturb	w3, [x29, #-0x5]
               	mov	x5, #0x9                // =9
               	sturb	w5, [x29, #-0x4]
               	mov	x5, #0xa                // =10
               	sturb	w5, [x29, #-0x3]
               	sturb	w1, [x29, #-0x2]
               	mov	x1, #0xc                // =12
               	sturb	w1, [x29, #-0x1]
               	sub	x5, x29, #0x20
               	ldur	x6, [x29, #-0x8]
               	stur	x6, [x29, #-0x20]
               	fmov	d5, #1.50000000
               	mov	x6, #0x6                // =6
               	sturb	w6, [x29, #-0x8]
               	sturb	w2, [x29, #-0x7]
               	sturb	w3, [x29, #-0x6]
               	mov	x2, #0x9                // =9
               	sturb	w2, [x29, #-0x5]
               	mov	x2, #0xa                // =10
               	sturb	w2, [x29, #-0x4]
               	mov	x2, #0xb                // =11
               	sturb	w2, [x29, #-0x3]
               	sturb	w1, [x29, #-0x2]
               	mov	x1, #0xd                // =13
               	sturb	w1, [x29, #-0x1]
               	sub	x1, x29, #0x18
               	ldur	x2, [x29, #-0x8]
               	stur	x2, [x29, #-0x18]
               	str	d4, [sp]
               	str	d5, [sp, #0x10]
               	mov	x16, x5
               	ldr	x17, [x16]
               	str	x17, [sp, #0x8]
               	mov	x16, x1
               	ldr	x17, [x16]
               	str	x17, [sp, #0x18]
               	fmov	d4, d2
               	fmov	d6, d3
               	fmov	d2, d1
               	ldr	d1, [x7]
               	ldr	d3, [x9]
               	ldr	d5, [x8]
               	ldr	d7, [x4]
               	bl	<addr>
               	fcmp	d0, d8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
