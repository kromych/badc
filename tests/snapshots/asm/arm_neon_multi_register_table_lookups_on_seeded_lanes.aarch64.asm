
arm_neon_multi_register_table_lookups_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<u8v>:
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[0], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[1], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[2], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[3], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[4], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[5], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[6], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[7], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x0, x0, #0xff
               	mov	v0.b[8], w0
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[9], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[10], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[11], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[12], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[13], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	and	x2, x0, #0xff
               	mov	v0.b[14], w2
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x0, x0, #0xff
               	mov	v0.b[15], w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x6a0
               	str	x20, [sp]
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	str	q0, [sp, #0x10]
               	bl	<addr>
               	str	q0, [sp, #0x20]
               	bl	<addr>
               	str	q0, [sp, #0x30]
               	bl	<addr>
               	str	q0, [sp, #0x40]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sub	x2, x29, #0x570
               	and	x3, x1, #0x3
               	cbnz	w3, <addr>
               	ubfx	x1, x1, #8, #8
               	b	<addr>
               	lsr	x1, x1, #8
               	mov	x3, #0x83a9             // =33705
               	movk	x3, #0xa83a, lsl #16
               	movk	x3, #0x3a83, lsl #32
               	movk	x3, #0x3a8, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x46              // =70
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	b	<addr>
               	ldr	q2, [sp, #0x130]
               	str	q2, [sp, #0x4f0]
               	bl	<addr>
               	ldr	q2, [sp, #0x4f0]
               	sub	x0, x29, #0x690
               	sub	x2, x29, #0x650
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	add	x3, x0, #0x10
               	add	x1, x2, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x630
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x4, x1, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	add	x0, x0, #0x20
               	add	x3, x1, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x3, x29, #0x560
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldr	q1, [sp, #0x50]
               	tbl	v3.16b, { v1.16b }, v2.16b
               	movi	v1.16b, #0x10
               	sub	v4.16b, v2.16b, v1.16b
               	ldr	q5, [sp, #0x60]
               	tbx	v3.16b, { v5.16b }, v4.16b
               	str	q3, [sp, #0xa0]
               	sub	x0, x29, #0x540
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x1, x29, #0x510
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x10
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldr	q3, [sp, #0x190]
               	tbl	v3.16b, { v3.16b }, v2.16b
               	sub	v1.16b, v2.16b, v1.16b
               	ldr	q4, [sp, #0x1a0]
               	mov	v16.16b, v3.16b
               	tbx	v16.16b, { v4.16b }, v1.16b
               	mov	v1.16b, v16.16b
               	movi	v3.16b, #0x20
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x180]
               	tbx	v1.16b, { v4.16b }, v3.16b
               	str	q1, [sp, #0xb0]
               	sub	x1, x29, #0x690
               	sub	x0, x29, #0x4f0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x4b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x10
               	add	x3, x1, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x560
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q1, [sp, #0x1f0]
               	tbl	v1.16b, { v1.16b }, v2.16b
               	movi	v3.16b, #0x10
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x200]
               	mov	v16.16b, v1.16b
               	tbx	v16.16b, { v4.16b }, v3.16b
               	mov	v3.16b, v16.16b
               	add	x2, x0, #0x20
               	sub	x1, x29, #0x490
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x30
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	movi	v1.16b, #0x20
               	sub	v1.16b, v2.16b, v1.16b
               	sub	x0, x29, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q4, [sp, #0x210]
               	mov	v16.16b, v3.16b
               	tbx	v16.16b, { v4.16b }, v1.16b
               	mov	v4.16b, v16.16b
               	movi	v3.16b, #0x10
               	sub	v1.16b, v1.16b, v3.16b
               	ldr	q5, [sp, #0x220]
               	mov	v16.16b, v4.16b
               	tbx	v16.16b, { v5.16b }, v1.16b
               	mov	v1.16b, v16.16b
               	str	q1, [sp, #0xc0]
               	sub	x1, x29, #0x650
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q1, [sp, #0x50]
               	mov	v16.16b, v0.16b
               	tbx	v16.16b, { v1.16b }, v2.16b
               	mov	v1.16b, v16.16b
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x60]
               	tbx	v1.16b, { v4.16b }, v3.16b
               	str	q1, [sp, #0xd0]
               	sub	x1, x29, #0x630
               	sub	x0, x29, #0x450
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x1, x29, #0x420
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x10
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q1, [sp, #0x280]
               	mov	v16.16b, v0.16b
               	tbx	v16.16b, { v1.16b }, v2.16b
               	mov	v1.16b, v16.16b
               	movi	v3.16b, #0x10
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x290]
               	tbx	v1.16b, { v4.16b }, v3.16b
               	movi	v3.16b, #0x20
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x270]
               	tbx	v1.16b, { v4.16b }, v3.16b
               	str	q1, [sp, #0xe0]
               	sub	x1, x29, #0x690
               	sub	x0, x29, #0x400
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x3c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x10
               	add	x3, x1, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q1, [sp, #0x2e0]
               	mov	v16.16b, v0.16b
               	tbx	v16.16b, { v1.16b }, v2.16b
               	mov	v1.16b, v16.16b
               	movi	v3.16b, #0x10
               	sub	v3.16b, v2.16b, v3.16b
               	ldr	q4, [sp, #0x2f0]
               	mov	v16.16b, v1.16b
               	tbx	v16.16b, { v4.16b }, v3.16b
               	mov	v3.16b, v16.16b
               	add	x2, x0, #0x20
               	sub	x1, x29, #0x3a0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x30
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	movi	v1.16b, #0x20
               	sub	v1.16b, v2.16b, v1.16b
               	sub	x0, x29, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q4, [sp, #0x300]
               	tbx	v3.16b, { v4.16b }, v1.16b
               	movi	v4.16b, #0x10
               	sub	v1.16b, v1.16b, v4.16b
               	ldr	q4, [sp, #0x310]
               	mov	v16.16b, v3.16b
               	tbx	v16.16b, { v4.16b }, v1.16b
               	mov	v1.16b, v16.16b
               	str	q1, [sp, #0xf0]
               	mov	d1, v2.d[0]
               	mov	d3, v0.d[0]
               	sub	x0, x29, #0x650
               	sub	x2, x29, #0x380
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q4, [sp, #0x50]
               	tbl	v5.8b, { v4.16b }, v1.8b
               	movi	v4.8b, #0x10
               	sub	v6.8b, v1.8b, v4.8b
               	ldr	q7, [sp, #0x60]
               	tbx	v5.8b, { v7.16b }, v6.8b
               	mov	x0, v5.d[0]
               	str	x0, [sp, #0x518]
               	sub	x1, x29, #0x690
               	sub	x0, x29, #0x360
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x320
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x3, x0, #0x10
               	add	x4, x1, #0x10
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q5, [sp, #0x380]
               	tbl	v5.8b, { v5.16b }, v1.8b
               	sub	v4.8b, v1.8b, v4.8b
               	ldr	q6, [sp, #0x390]
               	tbx	v5.8b, { v6.16b }, v4.8b
               	add	x2, x0, #0x20
               	sub	x1, x29, #0x300
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x30
               	add	x2, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	movi	v4.8b, #0x20
               	sub	v4.8b, v1.8b, v4.8b
               	sub	x2, x29, #0x210
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q6, [sp, #0x3a0]
               	mov	v16.16b, v5.16b
               	tbx	v16.8b, { v6.16b }, v4.8b
               	mov	v6.16b, v16.16b
               	movi	v5.8b, #0x10
               	sub	v4.8b, v4.8b, v5.8b
               	ldr	q7, [sp, #0x3b0]
               	mov	v16.16b, v6.16b
               	tbx	v16.8b, { v7.16b }, v4.8b
               	mov	v4.16b, v16.16b
               	mov	x0, v4.d[0]
               	str	x0, [sp, #0x520]
               	sub	x1, x29, #0x630
               	sub	x0, x29, #0x2e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x1, x29, #0x2b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x10
               	add	x3, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	q4, [sp, #0x3f0]
               	mov	v16.16b, v3.16b
               	tbx	v16.8b, { v4.16b }, v1.8b
               	mov	v4.16b, v16.16b
               	sub	v5.8b, v1.8b, v5.8b
               	ldr	q6, [sp, #0x400]
               	tbx	v4.8b, { v6.16b }, v5.8b
               	movi	v5.8b, #0x20
               	sub	v5.8b, v1.8b, v5.8b
               	ldr	q6, [sp, #0x3e0]
               	tbx	v4.8b, { v6.16b }, v5.8b
               	mov	x0, v4.d[0]
               	str	x0, [sp, #0x528]
               	ldr	q4, [sp, #0x10]
               	sub	x0, x29, #0x5a0
               	str	q4, [sp, #0x100]
               	ldr	q4, [sp, #0x40]
               	str	q4, [sp, #0x110]
               	sub	x1, x29, #0x290
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q4, [sp, #0x100]
               	tbx	v0.16b, { v4.16b }, v2.16b
               	movi	v4.16b, #0x10
               	sub	v2.16b, v2.16b, v4.16b
               	ldr	q4, [sp, #0x110]
               	tbx	v0.16b, { v4.16b }, v2.16b
               	str	q0, [sp, #0x120]
               	ldr	d0, [sp, #0x10]
               	sub	x0, x29, #0x60
               	stur	d0, [x29, #-0x60]
               	ldr	d0, [sp, #0x28]
               	stur	d0, [x29, #-0x58]
               	ldr	d0, [sp, #0x30]
               	stur	d0, [x29, #-0x50]
               	ldr	d0, [sp, #0x48]
               	stur	d0, [x29, #-0x48]
               	sub	x2, x29, #0x120
               	ldr	x16, [x0]
               	str	x16, [x2]
               	add	x3, x0, #0x8
               	add	x1, x2, #0x8
               	ldr	x16, [x3]
               	str	x16, [x1]
               	sub	x1, x29, #0xf0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x4, x1, #0x8
               	ldr	x16, [x3]
               	str	x16, [x4]
               	add	x0, x0, #0x10
               	add	x3, x1, #0x10
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldur	d2, [x29, #-0x60]
               	movi	d0, #0000000000000000
               	mov	v2.d[1], v0.d[0]
               	tbl	v2.8b, { v2.16b }, v1.8b
               	mov	x0, v2.d[0]
               	str	x0, [sp, #0x530]
               	sub	x0, x29, #0x110
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	d2, [sp, #0x580]
               	ldr	d4, [sp, #0x588]
               	mov	v2.d[1], v4.d[0]
               	tbl	v2.8b, { v2.16b }, v1.8b
               	mov	x0, v2.d[0]
               	str	x0, [sp, #0x538]
               	sub	x0, x29, #0xc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldur	d2, [x29, #-0xf0]
               	ldur	d4, [x29, #-0xe8]
               	mov	v2.d[1], v4.d[0]
               	sub	x1, x29, #0x270
               	str	q2, [sp, #0x430]
               	ldur	d2, [x29, #-0xb0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x440]
               	sub	x0, x29, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q0, [sp, #0x430]
               	tbl	v2.8b, { v0.16b }, v1.8b
               	movi	v0.8b, #0x10
               	sub	v4.8b, v1.8b, v0.8b
               	ldr	q5, [sp, #0x440]
               	tbx	v2.8b, { v5.16b }, v4.8b
               	mov	x1, v2.d[0]
               	str	x1, [sp, #0x540]
               	sub	x1, x29, #0x60
               	sub	x2, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldur	d2, [x29, #-0x60]
               	ldur	d4, [x29, #-0x58]
               	mov	v2.d[1], v4.d[0]
               	sub	x1, x29, #0x250
               	str	q2, [sp, #0x450]
               	ldur	d2, [x29, #-0x30]
               	ldur	d4, [x29, #-0x28]
               	mov	v2.d[1], v4.d[0]
               	str	q2, [sp, #0x460]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	q2, [sp, #0x450]
               	tbl	v2.8b, { v2.16b }, v1.8b
               	sub	v0.8b, v1.8b, v0.8b
               	ldr	q4, [sp, #0x460]
               	mov	v16.16b, v2.16b
               	tbx	v16.8b, { v4.16b }, v0.8b
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x548]
               	ldur	d0, [x29, #-0x58]
               	movi	v2.8b, #0x8
               	cmhi	v2.8b, v2.8b, v1.8b
               	movi	d4, #0000000000000000
               	mov	v0.d[1], v4.d[0]
               	tbl	v0.8b, { v0.16b }, v1.8b
               	mov	v16.16b, v2.16b
               	bsl	v16.8b, v0.8b, v3.8b
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x550]
               	sub	x0, x29, #0x120
               	sub	x1, x29, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x580]
               	ldr	d2, [sp, #0x588]
               	mov	v0.d[1], v2.d[0]
               	mov	v16.16b, v3.16b
               	tbx	v16.8b, { v0.16b }, v1.8b
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x558]
               	sub	x1, x29, #0xf0
               	sub	x0, x29, #0xa8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	movi	v0.8b, #0x18
               	cmhi	v2.8b, v0.8b, v1.8b
               	sub	x1, x29, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	ldur	d0, [x29, #-0xa8]
               	ldur	d4, [x29, #-0xa0]
               	mov	v0.d[1], v4.d[0]
               	sub	x0, x29, #0x270
               	str	q0, [sp, #0x430]
               	movi	d0, #0000000000000000
               	ldur	d4, [x29, #-0xb0]
               	zip1	v0.2d, v4.2d, v0.2d
               	str	q0, [sp, #0x440]
               	sub	x1, x29, #0x380
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x430]
               	tbl	v4.8b, { v0.16b }, v1.8b
               	movi	v0.8b, #0x10
               	sub	v5.8b, v1.8b, v0.8b
               	ldr	q6, [sp, #0x440]
               	tbx	v4.8b, { v6.16b }, v5.8b
               	bsl	v2.8b, v4.8b, v3.8b
               	mov	x0, v2.d[0]
               	str	x0, [sp, #0x560]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	d2, [x29, #-0x60]
               	ldur	d4, [x29, #-0x58]
               	mov	v2.d[1], v4.d[0]
               	sub	x0, x29, #0x230
               	str	q2, [sp, #0x470]
               	ldur	d2, [x29, #-0x10]
               	ldur	d4, [x29, #-0x8]
               	mov	v2.d[1], v4.d[0]
               	str	q2, [sp, #0x480]
               	sub	x1, x29, #0x210
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q2, [sp, #0x470]
               	mov	v16.16b, v3.16b
               	tbx	v16.8b, { v2.16b }, v1.8b
               	mov	v2.16b, v16.16b
               	sub	v0.8b, v1.8b, v0.8b
               	ldr	q4, [sp, #0x480]
               	mov	v16.16b, v2.16b
               	tbx	v16.8b, { v4.16b }, v0.8b
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x568]
               	ldur	x0, [x29, #-0x60]
               	sub	x1, x29, #0xd8
               	stur	x0, [x29, #-0xd8]
               	ldur	x0, [x29, #-0x58]
               	stur	x0, [x29, #-0xd0]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0xc8]
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	movi	v0.8b, #0x18
               	cmhi	v0.8b, v0.8b, v1.8b
               	sub	x1, x29, #0x78
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	ldur	d2, [x29, #-0x90]
               	ldur	d4, [x29, #-0x88]
               	mov	v2.d[1], v4.d[0]
               	sub	x0, x29, #0x1f0
               	str	q2, [sp, #0x4b0]
               	movi	d2, #0000000000000000
               	ldur	d4, [x29, #-0x68]
               	zip1	v2.2d, v4.2d, v2.2d
               	str	q2, [sp, #0x4c0]
               	sub	x1, x29, #0x1d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q2, [sp, #0x4b0]
               	tbl	v2.8b, { v2.16b }, v1.8b
               	movi	v4.8b, #0x10
               	sub	v4.8b, v1.8b, v4.8b
               	ldr	q5, [sp, #0x4c0]
               	tbx	v2.8b, { v5.16b }, v4.8b
               	bsl	v0.8b, v2.8b, v3.8b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x570]
               	ldur	x0, [x29, #-0x50]
               	ldr	q0, [sp, #0x500]
               	mov	v0.d[0], x0
               	ldur	x0, [x29, #-0x48]
               	mov	v16.16b, v0.16b
               	mov	v16.d[1], x0
               	str	q16, [sp, #0x500]
               	ldr	q0, [sp, #0x500]
               	mov	d2, v0.d[0]
               	mov	d0, v0.d[1]
               	zip1	v0.2d, v2.2d, v0.2d
               	tbl	v0.8b, { v0.16b }, v1.8b
               	mov	x0, v0.d[0]
               	str	x0, [sp, #0x578]
               	sub	x2, x29, #0x600
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x5f0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x5e0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x5d0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x5c0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x5b0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x188
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x180
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x178
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x580
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x170
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x168
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x160
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x158
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x150
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x148
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x140
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x138
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x130
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x128
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x535b            // =21339
               	movk	x17, #0xf1b8, lsl #16
               	movk	x17, #0xe23, lsl #32
               	movk	x17, #0x2d53, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x20, [sp]
               	add	sp, sp, #0x6a0
               	ldp	x29, x30, [sp], #0x10
               	ret
