
arm_neon_doubling_multiplies_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1b0
               	mov	x8, #0x0                // =0
               	mov	x1, #0x1b3              // =435
               	movk	x1, #0x100, lsl #32
               	adrp	x2, <page>
               	adrp	x0, <page>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	strh	w4, [x6, x3, lsl #1]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	sub	x6, x29, #0xb0
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x8000            // =-32768
               	b	<addr>
               	mov	x7, #0x7fff             // =32767
               	lsr	x4, x4, #8
               	sxth	x4, w4
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	sub	x6, x29, #0xb0
               	ldur	q1, [x29, #-0xb0]
               	mov	x3, #0x0                // =0
               	b	<addr>
               	strh	w4, [x6, x3, lsl #1]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x8000            // =-32768
               	b	<addr>
               	mov	x7, #0x7fff             // =32767
               	lsr	x4, x4, #8
               	sxth	x4, w4
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	sub	x6, x29, #0xb0
               	ldur	q2, [x29, #-0xb0]
               	mov	x3, #0x0                // =0
               	b	<addr>
               	strh	w4, [x6, x3, lsl #1]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x8000            // =-32768
               	b	<addr>
               	mov	x7, #0x7fff             // =32767
               	lsr	x4, x4, #8
               	sxth	x4, w4
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	ldur	q19, [x29, #-0xb0]
               	mov	x3, #0x0                // =0
               	b	<addr>
               	str	w4, [x6, x3, lsl #2]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	sub	x6, x29, #0xa0
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x80000000        // =-2147483648
               	b	<addr>
               	mov	x7, #0x7fffffff         // =2147483647
               	lsr	x4, x4, #16
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	sub	x6, x29, #0xa0
               	ldur	q0, [x29, #-0xa0]
               	mov	x3, #0x0                // =0
               	b	<addr>
               	str	w4, [x6, x3, lsl #2]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x80000000        // =-2147483648
               	b	<addr>
               	mov	x7, #0x7fffffff         // =2147483647
               	lsr	x4, x4, #16
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	sub	x6, x29, #0xa0
               	ldur	q3, [x29, #-0xa0]
               	mov	x3, #0x0                // =0
               	b	<addr>
               	str	w4, [x6, x3, lsl #2]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.ge	<addr>
               	ldr	x4, [x2, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x2, #0x10]
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #-0x80000000        // =-2147483648
               	b	<addr>
               	mov	x7, #0x7fffffff         // =2147483647
               	lsr	x4, x4, #16
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	ldur	q20, [x29, #-0xa0]
               	mov	x4, #0x0                // =0
               	b	<addr>
               	str	x3, [x5, x4, lsl #3]
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.ge	<addr>
               	ldr	x3, [x2, #0x10]
               	eor	x3, x3, x3, lsl #13
               	eor	x3, x3, x3, lsr #7
               	eor	x3, x3, x3, lsl #17
               	str	x3, [x2, #0x10]
               	sub	x5, x29, #0x90
               	and	x3, x3, #0x7
               	cbnz	w3, <addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	cmp	w3, #0x1
               	b.ne	<addr>
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	b	<addr>
               	ldr	x3, [x2, #0x10]
               	eor	x3, x3, x3, lsl #13
               	eor	x3, x3, x3, lsr #7
               	eor	x3, x3, x3, lsl #17
               	str	x3, [x2, #0x10]
               	b	<addr>
               	ldur	q21, [x29, #-0x90]
               	mov	d4, v1.d[0]
               	mov	d5, v2.d[0]
               	mov	d22, v19.d[0]
               	mov	d6, v0.d[0]
               	mov	d7, v3.d[0]
               	mov	d23, v20.d[0]
               	sqdmulh	v24.8h, v1.8h, v2.8h
               	str	q24, [sp]
               	sqrdmulh	v24.8h, v1.8h, v2.8h
               	str	q24, [sp, #0x10]
               	mov	v24.16b, v19.16b
               	sqrdmlah	v24.8h, v1.8h, v2.8h
               	str	q24, [sp, #0x20]
               	mov	v24.16b, v19.16b
               	sqrdmlsh	v24.8h, v1.8h, v2.8h
               	str	q24, [sp, #0x30]
               	sqdmulh	v24.4h, v4.4h, v5.4h
               	stur	d24, [x29, #-0x78]
               	sqrdmulh	v24.4h, v4.4h, v5.4h
               	stur	d24, [x29, #-0x70]
               	mov	v24.16b, v22.16b
               	sqrdmlah	v24.4h, v4.4h, v5.4h
               	stur	d24, [x29, #-0x68]
               	sqrdmlsh	v22.4h, v4.4h, v5.4h
               	stur	d22, [x29, #-0x60]
               	sqdmulh	v22.4s, v0.4s, v3.4s
               	str	q22, [sp, #0x40]
               	sqrdmulh	v22.4s, v0.4s, v3.4s
               	str	q22, [sp, #0x50]
               	mov	v22.16b, v20.16b
               	sqrdmlah	v22.4s, v0.4s, v3.4s
               	str	q22, [sp, #0x60]
               	sqrdmlsh	v20.4s, v0.4s, v3.4s
               	str	q20, [sp, #0x70]
               	sqdmulh	v20.2s, v6.2s, v7.2s
               	stur	d20, [x29, #-0x58]
               	sqrdmulh	v20.2s, v6.2s, v7.2s
               	stur	d20, [x29, #-0x50]
               	mov	v20.16b, v23.16b
               	sqrdmlah	v20.2s, v6.2s, v7.2s
               	stur	d20, [x29, #-0x48]
               	mov	v20.16b, v23.16b
               	sqrdmlsh	v20.2s, v6.2s, v7.2s
               	stur	d20, [x29, #-0x40]
               	sqdmull	v20.4s, v4.4h, v5.4h
               	str	q20, [sp, #0x80]
               	sqdmull2	v20.4s, v1.8h, v2.8h
               	str	q20, [sp, #0x90]
               	mov	v16.16b, v0.16b
               	sqdmlal	v16.4s, v4.4h, v5.4h
               	mov	v4.16b, v16.16b
               	str	q4, [sp, #0xa0]
               	mov	v4.16b, v0.16b
               	sqdmlsl2	v4.4s, v1.8h, v2.8h
               	stur	q4, [x29, #-0x100]
               	sqdmull	v4.2d, v6.2s, v7.2s
               	stur	q4, [x29, #-0xf0]
               	sqdmull2	v4.2d, v0.4s, v3.4s
               	stur	q4, [x29, #-0xe0]
               	mov	v4.16b, v21.16b
               	sqdmlal2	v4.2d, v0.4s, v3.4s
               	stur	q4, [x29, #-0xd0]
               	mov	v4.16b, v21.16b
               	sqdmlsl	v4.2d, v6.2s, v7.2s
               	stur	q4, [x29, #-0xc0]
               	smov	x3, v1.h[0]
               	smov	x4, v2.h[0]
               	sxth	x5, w3
               	sxth	x4, w4
               	mov	x3, #0x0                // =0
               	fmov	d4, x3
               	mov	v4.h[0], w5
               	fmov	d5, x3
               	mov	v5.h[0], w4
               	sqdmulh	v4.4h, v4.4h, v5.4h
               	smov	x4, v4.h[0]
               	sxth	x4, w4
               	sturh	w4, [x29, #-0x38]
               	smov	x4, v19.h[1]
               	smov	x5, v1.h[1]
               	smov	x6, v2.h[1]
               	sxth	x4, w4
               	sxth	x5, w5
               	sxth	x6, w6
               	fmov	d4, x3
               	mov	v4.h[0], w4
               	fmov	d5, x3
               	mov	v5.h[0], w5
               	fmov	d6, x3
               	mov	v6.h[0], w6
               	sqrdmlah	v4.4h, v5.4h, v6.4h
               	smov	x4, v4.h[0]
               	sxth	x4, w4
               	sturh	w4, [x29, #-0x30]
               	smov	x4, v0.s[0]
               	smov	x5, v3.s[0]
               	fmov	s4, w4
               	fmov	s5, w5
               	sqrdmulh	v4.2s, v4.2s, v5.2s
               	smov	x4, v4.s[0]
               	stur	w4, [x29, #-0x28]
               	smov	x4, v1.h[2]
               	smov	x5, v2.h[2]
               	sxth	x4, w4
               	sxth	x5, w5
               	fmov	d4, x3
               	mov	v4.h[0], w4
               	fmov	d5, x3
               	mov	v5.h[0], w5
               	sqdmull	v4.4s, v4.4h, v5.4h
               	smov	x4, v4.s[0]
               	stur	w4, [x29, #-0x20]
               	smov	x4, v0.s[1]
               	smov	x5, v1.h[3]
               	smov	x6, v2.h[3]
               	sxth	x5, w5
               	sxth	x6, w6
               	fmov	s1, w4
               	fmov	d2, x3
               	mov	v2.h[0], w5
               	fmov	d4, x3
               	mov	v4.h[0], w6
               	sqdmlsl	v1.4s, v2.4h, v4.4h
               	smov	x4, v1.s[0]
               	stur	w4, [x29, #-0x18]
               	smov	x4, v0.s[2]
               	smov	x5, v3.s[2]
               	fmov	s1, w4
               	fmov	s2, w5
               	sqdmull	v1.2d, v1.2s, v2.2s
               	mov	x3, v1.d[0]
               	stur	x3, [x29, #-0x10]
               	mov	x4, v21.d[0]
               	smov	x5, v0.s[3]
               	smov	x6, v3.s[3]
               	mov	x3, #0x0                // =0
               	fmov	d0, x4
               	fmov	s1, w5
               	fmov	s2, w6
               	sqdmlal	v0.2d, v1.2s, v2.2s
               	mov	x4, v0.d[0]
               	stur	x4, [x29, #-0x8]
               	sub	x6, x29, #0x1b0
               	ldr	x4, [x0, #0x18]
               	ldrb	w5, [x6, x3]
               	eor	x4, x4, x5
               	mul	x4, x4, x1
               	str	x4, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x1a0
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x190
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x180
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x78
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x70
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x68
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x60
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x170
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x160
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x150
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x140
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x58
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x50
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x48
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x40
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x130
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x120
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x110
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x100
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0xf0
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0xe0
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0xd0
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0xc0
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x38
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x2
               	b.lo	<addr>
               	sub	x4, x29, #0x30
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x2
               	b.lo	<addr>
               	sub	x4, x29, #0x28
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.lo	<addr>
               	sub	x4, x29, #0x20
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.lo	<addr>
               	sub	x4, x29, #0x18
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x4
               	b.lo	<addr>
               	sub	x4, x29, #0x10
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x8
               	mov	x3, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x3]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lo	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x20e8            // =8424
               	movk	x17, #0xcdc, lsl #16
               	movk	x17, #0xdce2, lsl #32
               	movk	x17, #0xf4e1, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
