
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
               	sxtw	x0, w1
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
               	sxtw	x0, w1
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
               	sub	sp, sp, #0x20
               	mov	x3, x0
               	sub	x2, x29, #0x20
               	and	x1, x3, #0xff
               	strb	w1, [x2]
               	add	x0, x1, #0x1
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x1]
               	add	x0, x1, #0x2
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x2]
               	add	x0, x1, #0x3
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x3]
               	add	x0, x1, #0x4
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x4]
               	add	x0, x1, #0x5
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x5]
               	add	x0, x1, #0x6
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x6]
               	add	x0, x1, #0x7
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x7]
               	add	x0, x1, #0x8
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x8]
               	add	x0, x1, #0x9
               	and	x0, x0, #0xff
               	strb	w0, [x2, #0x9]
               	sub	x0, x29, #0x20
               	add	x2, x1, #0xa
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0xa]
               	add	x1, x1, #0xb
               	and	x1, x1, #0xff
               	strb	w1, [x0, #0xb]
               	and	x1, x3, #0xff
               	add	x2, x1, #0xc
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0xc]
               	add	x2, x1, #0xd
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0xd]
               	add	x2, x1, #0xe
               	and	x2, x2, #0xff
               	strb	w2, [x0, #0xe]
               	add	x1, x1, #0xf
               	and	x1, x1, #0xff
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x120]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x26, x27, [sp, #0x40]
               	str	x28, [sp, #0x50]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x20, #0x2               // =2
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	sub	x21, x29, #0x20
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	x7, x29, #0x10
               	ldr	q0, [x21]
               	ldr	q1, [x7]
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	mov	x20, #0xa               // =10
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	stur	q0, [x29, #-0xa0]
               	sub	x21, x29, #0xa0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	stur	q0, [x29, #-0x90]
               	sub	x22, x29, #0x90
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	sub	x23, x29, #0x80
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	sub	x24, x29, #0x70
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	q0, [x29, #-0x60]
               	sub	x25, x29, #0x60
               	mov	x0, #0x6                // =6
               	bl	<addr>
               	stur	q0, [x29, #-0x50]
               	sub	x26, x29, #0x50
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	sub	x27, x29, #0x40
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	stur	q0, [x29, #-0x30]
               	sub	x28, x29, #0x30
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	sub	x16, x29, #0x20
               	str	x16, [sp, #0x68]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	x7, x29, #0x10
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x88]
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	q0, [x21]
               	ldr	q1, [x22]
               	ldr	q2, [x23]
               	ldr	q3, [x24]
               	ldr	q4, [x25]
               	ldr	q5, [x26]
               	ldr	q6, [x27]
               	ldr	q7, [x28]
               	mov	x0, x20
               	bl	<addr>
               	add	sp, sp, #0x20
               	cmp	x0, #0x104
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	sub	x7, x29, #0x8
               	mov	x0, #0x5                // =5
               	strb	w0, [x7]
               	mov	x0, #0x6                // =6
               	strb	w0, [x7, #0x1]
               	mov	x0, #0x7                // =7
               	strb	w0, [x7, #0x2]
               	mov	x0, #0x8                // =8
               	strb	w0, [x7, #0x3]
               	mov	x0, #0x9                // =9
               	strb	w0, [x7, #0x4]
               	mov	x0, #0xa                // =10
               	strb	w0, [x7, #0x5]
               	mov	x0, #0xb                // =11
               	strb	w0, [x7, #0x6]
               	mov	x0, #0xc                // =12
               	strb	w0, [x7, #0x7]
               	mov	x0, #0x1                // =1
               	ldr	d0, [x7]
               	bl	<addr>
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	mov	x20, #0x2               // =2
               	mov	x21, #0x7               // =7
               	fmov	d8, #0.50000000
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	sub	x22, x29, #0x20
               	mov	x23, #0x9               // =9
               	fmov	d9, #0.25000000
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	x7, x29, #0x10
               	fmov	d0, d8
               	fmov	d2, d9
               	ldr	q1, [x22]
               	ldr	q3, [x7]
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	movi	d1, #0000000000000000
               	mov	x3, #0x1                // =1
               	scvtf	d2, x3
               	fmov	d0, #4.00000000
               	fdiv	d2, d2, d0
               	mov	x0, #0x9                // =9
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x2, #0x2                // =2
               	scvtf	d2, x2
               	fdiv	d2, d2, d0
               	mov	x0, #0xb                // =11
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x4, #0x3                // =3
               	scvtf	d2, x4
               	fdiv	d2, d2, d0
               	mov	x0, #0xd                // =13
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x5, #0x4                // =4
               	scvtf	d2, x5
               	fdiv	d2, d2, d0
               	mov	x0, #0xf                // =15
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x6, #0x5                // =5
               	scvtf	d2, x6
               	fdiv	d2, d2, d0
               	mov	x0, #0x11               // =17
               	scvtf	d3, x0
               	fadd	d2, d2, d3
               	fadd	d1, d1, d2
               	mov	x0, #0x6                // =6
               	scvtf	d2, x0
               	fdiv	d0, d2, d0
               	mov	x1, #0x13               // =19
               	scvtf	d2, x1
               	fadd	d0, d0, d2
               	fadd	d8, d1, d0
               	fmov	d0, #0.25000000
               	sub	x1, x29, #0x8
               	strb	w3, [x1]
               	strb	w2, [x1, #0x1]
               	strb	w4, [x1, #0x2]
               	strb	w5, [x1, #0x3]
               	strb	w6, [x1, #0x4]
               	strb	w0, [x1, #0x5]
               	mov	x3, #0x7                // =7
               	strb	w3, [x1, #0x6]
               	mov	x4, #0x8                // =8
               	strb	w4, [x1, #0x7]
               	sub	x7, x29, #0x68
               	ldr	x5, [x1]
               	str	x5, [x7]
               	fmov	d1, #0.50000000
               	strb	w2, [x1]
               	mov	x5, #0x3                // =3
               	strb	w5, [x1, #0x1]
               	sub	x1, x29, #0x8
               	mov	x6, #0x4                // =4
               	strb	w6, [x1, #0x2]
               	mov	x8, #0x5                // =5
               	strb	w8, [x1, #0x3]
               	mov	x9, #0x6                // =6
               	strb	w9, [x1, #0x4]
               	strb	w3, [x1, #0x5]
               	strb	w4, [x1, #0x6]
               	mov	x2, #0x9                // =9
               	strb	w2, [x1, #0x7]
               	sub	x3, x29, #0x58
               	ldr	x4, [x1]
               	str	x4, [x3]
               	fmov	d2, #0.75000000
               	strb	w5, [x1]
               	strb	w6, [x1, #0x1]
               	strb	w8, [x1, #0x2]
               	strb	w9, [x1, #0x3]
               	mov	x4, #0x7                // =7
               	strb	w4, [x1, #0x4]
               	sub	x1, x29, #0x8
               	mov	x5, #0x8                // =8
               	strb	w5, [x1, #0x5]
               	strb	w2, [x1, #0x6]
               	mov	x6, #0xa                // =10
               	strb	w6, [x1, #0x7]
               	sub	x8, x29, #0x48
               	ldr	x9, [x1]
               	str	x9, [x8]
               	fmov	d3, #1.00000000
               	mov	x9, #0x4                // =4
               	strb	w9, [x1]
               	mov	x9, #0x5                // =5
               	strb	w9, [x1, #0x1]
               	mov	x10, #0x6               // =6
               	strb	w10, [x1, #0x2]
               	strb	w4, [x1, #0x3]
               	strb	w5, [x1, #0x4]
               	strb	w2, [x1, #0x5]
               	sub	x1, x29, #0x8
               	strb	w6, [x1, #0x6]
               	mov	x2, #0xb                // =11
               	strb	w2, [x1, #0x7]
               	sub	x4, x29, #0x38
               	ldr	x5, [x1]
               	str	x5, [x4]
               	fmov	d4, #1.25000000
               	strb	w9, [x1]
               	strb	w10, [x1, #0x1]
               	mov	x5, #0x7                // =7
               	strb	w5, [x1, #0x2]
               	mov	x6, #0x8                // =8
               	strb	w6, [x1, #0x3]
               	mov	x9, #0x9                // =9
               	strb	w9, [x1, #0x4]
               	mov	x9, #0xa                // =10
               	strb	w9, [x1, #0x5]
               	sub	x1, x29, #0x8
               	strb	w2, [x1, #0x6]
               	mov	x2, #0xc                // =12
               	strb	w2, [x1, #0x7]
               	sub	x9, x29, #0x28
               	ldr	x10, [x1]
               	str	x10, [x9]
               	fmov	d5, #1.50000000
               	mov	x10, #0x6               // =6
               	strb	w10, [x1]
               	strb	w5, [x1, #0x1]
               	strb	w6, [x1, #0x2]
               	mov	x5, #0x9                // =9
               	strb	w5, [x1, #0x3]
               	sub	x1, x29, #0x8
               	mov	x5, #0xa                // =10
               	strb	w5, [x1, #0x4]
               	mov	x5, #0xb                // =11
               	strb	w5, [x1, #0x5]
               	strb	w2, [x1, #0x6]
               	mov	x2, #0xd                // =13
               	strb	w2, [x1, #0x7]
               	sub	x2, x29, #0x18
               	ldr	x1, [x1]
               	str	x1, [x2]
               	sub	sp, sp, #0x20
               	str	d4, [sp]
               	str	d5, [sp, #0x10]
               	mov	x16, x9
               	ldr	x17, [x16]
               	str	x17, [sp, #0x8]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp, #0x18]
               	fmov	d4, d2
               	fmov	d6, d3
               	fmov	d2, d1
               	ldr	d1, [x7]
               	ldr	d3, [x3]
               	ldr	d5, [x8]
               	ldr	d7, [x4]
               	bl	<addr>
               	add	sp, sp, #0x20
               	fcmp	d0, d8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
