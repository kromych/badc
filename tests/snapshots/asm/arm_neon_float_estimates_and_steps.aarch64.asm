
arm_neon_float_estimates_and_steps.aarch64:	file format elf64-littleaarch64

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

<rsqrte_bits>:
               	lsr	x3, x2, #45
               	orr	x3, x3, #0x80
               	lsr	x2, x2, #44
               	orr	x2, x2, #0x100
               	tst	x1, #0x1
               	csel	x2, x3, x2, ne
               	mov	x3, #0x17c              // =380
               	mov	x4, #0xbfc              // =3068
               	cmp	w0, #0x20
               	csel	x3, x3, x4, eq
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	add	x1, x1, x1, lsr #63
               	asr	x6, x1, #1
               	cmp	w2, #0x100
               	b.ge	<addr>
               	lsl	x1, x2, #1
               	add	x3, x1, #0x1
               	mov	x4, #0x10000000         // =268435456
               	mov	x2, #0x200              // =512
               	add	x1, x2, #0x1
               	mul	x5, x3, x1
               	mul	x5, x5, x1
               	cmp	x5, x4
               	b.ge	<addr>
               	mov	x2, x1
               	add	x1, x2, #0x1
               	mul	x5, x3, x1
               	mul	x5, x5, x1
               	cmp	x5, x4
               	b.lt	<addr>
               	add	x1, x2, #0x1
               	add	x1, x1, x1, lsr #63
               	ubfx	x1, x1, #1, #8
               	lsl	x1, x1, #44
               	cmp	w0, #0x20
               	b.ne	<addr>
               	lsl	x0, x6, #23
               	orr	x0, x0, x1, lsr #29
               	ret
               	orr	x0, x1, x6, lsl #52
               	b	<addr>
               	asr	x1, x2, #1
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	lsl	x3, x1, #1
               	b	<addr>

<f2u>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<u2f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0xf0]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x26, x27, [sp, #0x40]
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x26, #0x0               // =0
               	mov	x25, #0x0               // =0
               	add	x27, x26, #0x1
               	b	<addr>
               	add	x25, x25, #0x1
               	cmp	w25, #0x2
               	b.ge	<addr>
               	add	x21, x25, #0x78
               	add	x22, x25, #0x3f2
               	lsl	x20, x21, #23
               	orr	x0, x20, x26, lsl #15
               	bl	<addr>
               	stur	s0, [x29, #-0x20]
               	mov	x0, #0x1357             // =4951
               	orr	x0, x0, x27, lsl #15
               	orr	x0, x20, x0
               	bl	<addr>
               	stur	s0, [x29, #-0x1c]
               	mov	x0, #0x26ae             // =9902
               	orr	x0, x0, x26, lsl #15
               	orr	x0, x20, x0
               	bl	<addr>
               	stur	s0, [x29, #-0x18]
               	mov	x0, #0x3a05             // =14853
               	orr	x0, x0, x27, lsl #15
               	orr	x0, x0, x21, lsl #23
               	bl	<addr>
               	stur	s0, [x29, #-0x14]
               	lsl	x0, x22, #52
               	orr	x1, x0, x26, lsl #44
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x1, x1, x17
               	fmov	d3, x1
               	stur	x1, [x29, #-0x10]
               	orr	x0, x0, x27, lsl #44
               	mov	x17, #0xcf12            // =53010
               	movk	x17, #0x468a, lsl #16
               	movk	x17, #0x2, lsl #32
               	orr	x0, x0, x17
               	fmov	d0, x0
               	stur	x0, [x29, #-0x8]
               	ldur	q1, [x29, #-0x20]
               	mov	d2, v1.d[1]
               	mov	v3.d[1], v0.d[0]
               	frecpe	v4.4s, v1.4s
               	stur	q4, [x29, #-0x90]
               	frsqrte	v1.4s, v1.4s
               	stur	q1, [x29, #-0x80]
               	frecpe	v1.2s, v2.2s
               	stur	d1, [x29, #-0x30]
               	frsqrte	v1.2s, v2.2s
               	stur	d1, [x29, #-0x28]
               	frecpe	v1.2d, v3.2d
               	stur	q1, [x29, #-0x70]
               	frsqrte	v1.2d, v3.2d
               	stur	q1, [x29, #-0x60]
               	frecpe	d8, d0
               	frsqrte	d9, d0
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.ge	<addr>
               	sub	x0, x29, #0x20
               	lsl	x23, x20, #2
               	add	x0, x0, x23
               	ldr	s0, [x0]
               	bl	<addr>
               	and	x0, x0, #0x7fffff
               	lsl	x24, x0, #29
               	sub	x0, x29, #0x90
               	add	x0, x0, x23
               	ldr	s0, [x0]
               	bl	<addr>
               	lsr	x1, x24, #44
               	orr	x1, x1, #0x100
               	mov	x2, #0xfd               // =253
               	sub	x2, x2, x21
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	mov	x3, #0x80000            // =524288
               	sdiv	w1, w3, w1
               	add	x1, x1, #0x1
               	ubfx	x1, x1, #1, #8
               	lsl	x1, x1, #44
               	lsl	x2, x2, #23
               	orr	x1, x2, x1, lsr #29
               	cmp	w0, w1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x80
               	add	x0, x0, x20, lsl #2
               	ldr	s0, [x0]
               	bl	<addr>
               	mov	w23, w0
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	mov	x2, x24
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x2
               	b.ge	<addr>
               	sub	x0, x29, #0x20
               	add	x1, x20, #0x2
               	add	x0, x0, x1, lsl #2
               	ldr	s0, [x0]
               	bl	<addr>
               	and	x0, x0, #0x7fffff
               	lsl	x23, x0, #29
               	sub	x0, x29, #0x30
               	add	x0, x0, x20, lsl #2
               	ldr	s0, [x0]
               	bl	<addr>
               	lsr	x1, x23, #44
               	orr	x1, x1, #0x100
               	mov	x2, #0xfd               // =253
               	sub	x2, x2, x21
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	mov	x3, #0x80000            // =524288
               	sdiv	w1, w3, w1
               	add	x1, x1, #0x1
               	ubfx	x1, x1, #1, #8
               	lsl	x1, x1, #44
               	lsl	x2, x2, #23
               	orr	x1, x2, x1, lsr #29
               	cmp	w0, w1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x28
               	add	x0, x0, x20, lsl #2
               	ldr	s0, [x0]
               	bl	<addr>
               	mov	w24, w0
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	mov	x2, x23
               	bl	<addr>
               	cmp	x24, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	sub	x1, x29, #0x10
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	d0, [x1]
               	fmov	x1, d0
               	and	x1, x1, #0xfffffffffffff
               	sub	x2, x29, #0x70
               	add	x2, x2, x0
               	ldr	d0, [x2]
               	fmov	x2, d0
               	lsr	x3, x1, #44
               	orr	x3, x3, #0x100
               	mov	x4, #0x7fd              // =2045
               	sub	x4, x4, x22
               	lsl	x3, x3, #1
               	add	x3, x3, #0x1
               	mov	x5, #0x80000            // =524288
               	sdiv	w3, w5, w3
               	add	x3, x3, #0x1
               	ubfx	x3, x3, #1, #8
               	lsl	x4, x4, #52
               	orr	x3, x4, x3, lsl #44
               	cmp	x2, x3
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x20]
               	orr	x3, x3, #0x1
               	str	w3, [x2, #0x20]
               	sub	x2, x29, #0x60
               	add	x0, x2, x0
               	ldr	d0, [x0]
               	fmov	x23, d0
               	mov	x0, #0x40               // =64
               	mov	x2, x1
               	mov	x1, x22
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	b	<addr>
               	ldur	d0, [x29, #-0x8]
               	fmov	x0, d0
               	and	x1, x0, #0xfffffffffffff
               	fmov	x0, d8
               	lsr	x2, x1, #44
               	orr	x2, x2, #0x100
               	mov	x3, #0x7fd              // =2045
               	sub	x3, x3, x22
               	lsl	x2, x2, #1
               	add	x2, x2, #0x1
               	mov	x4, #0x80000            // =524288
               	sdiv	w2, w4, w2
               	add	x2, x2, #0x1
               	ubfx	x2, x2, #1, #8
               	lsl	x3, x3, #52
               	orr	x2, x3, x2, lsl #44
               	cmp	x0, x2
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x20]
               	orr	x2, x2, #0x1
               	str	w2, [x0, #0x20]
               	fmov	x20, d9
               	mov	x0, #0x40               // =64
               	mov	x2, x1
               	mov	x1, x22
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	b	<addr>
               	add	x26, x26, #0x2
               	cmp	w26, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fmov	s0, s17
               	mov	x0, #0x80000000         // =2147483648
               	fmov	d17, x0
               	mov	v0.s[1], v17.s[0]
               	mov	x0, #0x7f800000         // =2139095040
               	fmov	d17, x0
               	mov	v0.s[2], v17.s[0]
               	mov	x0, #0xff800000         // =4286578688
               	fmov	d17, x0
               	mov	v0.s[3], v17.s[0]
               	frecpe	v16.4s, v0.4s
               	str	q16, [sp, #0xa0]
               	frsqrte	v16.4s, v0.4s
               	str	q16, [sp, #0x90]
               	ldr	q16, [sp, #0xa0]
               	mov	s0, v16.s[0]
               	bl	<addr>
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	q16, [sp, #0xa0]
               	mov	s0, v16.s[1]
               	bl	<addr>
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	ldr	q16, [sp, #0xa0]
               	mov	s0, v16.s[2]
               	bl	<addr>
               	cbnz	w0, <addr>
               	ldr	q16, [sp, #0xa0]
               	mov	s0, v16.s[3]
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x20]
               	frecpe	v0.2s, v0.2s
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x28]
               	frecpe	v0.2s, v0.2s
               	mov	s0, v0.s[1]
               	bl	<addr>
               	orr	x0, x0, #0x80000000
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	ldr	q16, [sp, #0x90]
               	mov	s0, v16.s[0]
               	bl	<addr>
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	q16, [sp, #0x90]
               	mov	s0, v16.s[1]
               	bl	<addr>
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	q16, [sp, #0x90]
               	mov	s0, v16.s[2]
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	ldr	q16, [sp, #0x90]
               	mov	s0, v16.s[3]
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	ubfx	x1, x0, #23, #8
               	and	x0, x0, #0x7fffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	cbnz	w0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	frsqrte	v0.2d, v0.2d
               	fmov	x0, d0
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	ldr	q0, [x3]
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldr	q1, [x4]
               	frecps	v2.4s, v0.4s, v1.4s
               	sub	x7, x29, #0x70
               	stur	q2, [x29, #-0x70]
               	frsqrts	v2.4s, v0.4s, v1.4s
               	sub	x8, x29, #0x60
               	stur	q2, [x29, #-0x60]
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	frecps	v2.2s, v2.2s, v3.2s
               	sub	x9, x29, #0x18
               	stur	d2, [x29, #-0x18]
               	mov	d0, v0.d[1]
               	mov	d1, v1.d[1]
               	frsqrts	v0.2s, v0.2s, v1.2s
               	sub	x10, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x2, x0, #2
               	add	x5, x7, x2
               	ldr	s0, [x5]
               	add	x5, x3, x2
               	ldr	s1, [x5]
               	fneg	s1, s1
               	add	x6, x4, x2
               	ldr	s2, [x6]
               	fmov	s3, #2.00000000
               	fmadd	s1, s1, s2, s3
               	fcmp	s0, s1
               	b.eq	<addr>
               	ldrsw	x11, [x1, #0x20]
               	orr	x11, x11, #0x4
               	str	w11, [x1, #0x20]
               	add	x2, x8, x2
               	ldr	s0, [x2]
               	ldr	s1, [x5]
               	fneg	s1, s1
               	ldr	s2, [x6]
               	fmov	s3, #3.00000000
               	fmadd	s1, s1, s2, s3
               	fmov	s2, #0.50000000
               	fmul	s1, s1, s2
               	fcmp	s0, s1
               	b.eq	<addr>
               	ldrsw	x2, [x1, #0x20]
               	orr	x2, x2, #0x8
               	str	w2, [x1, #0x20]
               	b	<addr>
               	movi	d0, #0000000000000000
               	adrp	x0, <page>
               	b	<addr>
               	smov	x1, v0.s[0]
               	add	x1, x1, #0x1
               	mov	v0.s[0], w1
               	smov	x1, v0.s[0]
               	cmp	x1, #0x2
               	b.ge	<addr>
               	smov	x1, v0.s[0]
               	lsl	x1, x1, #2
               	add	x2, x9, x1
               	ldr	s1, [x2]
               	add	x2, x3, x1
               	ldr	s2, [x2]
               	fneg	s2, s2
               	add	x1, x4, x1
               	ldr	s3, [x1]
               	fmov	s4, #2.00000000
               	fmadd	s2, s2, s3, s4
               	fcmp	s1, s2
               	b.eq	<addr>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	smov	x1, v0.s[0]
               	add	x2, x10, x1, lsl #2
               	ldr	s1, [x2]
               	add	x1, x1, #0x2
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x2, x3, x1
               	ldr	s2, [x2]
               	fneg	s2, s2
               	add	x1, x4, x1
               	ldr	s3, [x1]
               	fmov	s4, #3.00000000
               	fmadd	s2, s2, s3, s4
               	fmov	s3, #0.50000000
               	fmul	s2, s2, s3
               	fcmp	s1, s2
               	b.eq	<addr>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x20]
               	b	<addr>
               	sub	x5, x29, #0x90
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x5]
               	sub	x6, x29, #0x80
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x6]
               	ldur	q0, [x29, #-0x90]
               	ldur	q1, [x29, #-0x80]
               	frecps	v1.2d, v0.2d, v1.2d
               	sub	x7, x29, #0x70
               	stur	q1, [x29, #-0x70]
               	ldur	q1, [x29, #-0x80]
               	frsqrts	v0.2d, v0.2d, v1.2d
               	sub	x8, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	lsl	x2, x0, #3
               	add	x3, x7, x2
               	ldr	d0, [x3]
               	add	x3, x5, x2
               	ldr	d1, [x3]
               	fneg	d1, d1
               	add	x4, x6, x2
               	ldr	d2, [x4]
               	fmov	d3, #2.00000000
               	fmadd	d1, d1, d2, d3
               	fcmp	d0, d1
               	b.eq	<addr>
               	ldrsw	x9, [x1, #0x20]
               	orr	x9, x9, #0x4
               	str	w9, [x1, #0x20]
               	add	x2, x8, x2
               	ldr	d0, [x2]
               	ldr	d1, [x3]
               	fneg	d1, d1
               	ldr	d2, [x4]
               	fmov	d3, #3.00000000
               	fmadd	d1, d1, d2, d3
               	fmov	d2, #0.50000000
               	fmul	d1, d1, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	ldrsw	x2, [x1, #0x20]
               	orr	x2, x2, #0x8
               	str	w2, [x1, #0x20]
               	b	<addr>
               	adrp	x0, <addr>
               	ldr	d1, [x0, #0x60]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x68]
               	frecps	d4, d1, d0
               	fneg	d2, d1
               	fmov	d3, #2.00000000
               	fmadd	d5, d2, d0, d3
               	fcmp	d4, d5
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	frsqrts	d1, d1, d0
               	fmov	d4, #3.00000000
               	fmadd	d0, d2, d0, d4
               	fmov	d2, #0.50000000
               	fmul	d0, d0, d2
               	fcmp	d1, d0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x20]
               	mov	x0, #0x7f800000         // =2139095040
               	fmov	d17, x0
               	dup	v0.4s, v17.s[0]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	dup	v1.4s, v17.s[0]
               	frecps	v2.4s, v0.4s, v1.4s
               	mov	s4, v2.s[1]
               	fmov	s2, #2.00000000
               	fcmp	s4, s2
               	b.ne	<addr>
               	frecps	v4.4s, v1.4s, v0.4s
               	mov	s4, v4.s[2]
               	fcmp	s4, s2
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	frsqrts	v2.4s, v0.4s, v1.4s
               	mov	s4, v2.s[1]
               	fmov	s2, #1.50000000
               	fcmp	s4, s2
               	b.ne	<addr>
               	frsqrts	v0.4s, v1.4s, v0.4s
               	mov	s0, v0.s[3]
               	fcmp	s0, s2
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x20]
               	mov	x1, #0x7ff0000000000000 // =9218868437227405312
               	mov	x0, #0x0                // =0
               	fmov	d16, x1
               	fmov	d17, x0
               	frecps	d0, d16, d17
               	fcmp	d0, d3
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x20]
               	orr	x3, x3, #0x4
               	str	w3, [x2, #0x20]
               	fmov	d16, x0
               	fmov	d17, x1
               	frsqrts	d0, d16, d17
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x20]
               	orr	x2, x2, #0x8
               	str	w2, [x1, #0x20]
               	sub	x3, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldur	q0, [x29, #-0x80]
               	frecpe	v0.4s, v0.4s
               	sub	x4, x29, #0x70
               	stur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x80]
               	frecps	v1.4s, v1.4s, v0.4s
               	fmul	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x80]
               	frecps	v1.4s, v1.4s, v0.4s
               	fmul	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x80]
               	frsqrte	v0.4s, v1.4s
               	sub	x5, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	fmul	v2.4s, v1.4s, v0.4s
               	frsqrts	v2.4s, v2.4s, v0.4s
               	fmul	v0.4s, v0.4s, v2.4s
               	stur	q0, [x29, #-0x60]
               	fmul	v1.4s, v1.4s, v0.4s
               	frsqrts	v1.4s, v1.4s, v0.4s
               	fmul	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x60]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x80]
               	adrp	x16, <addr>
               	ldr	s1, [x16, #0x84]
               	adrp	x2, <page>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x1, x0, #2
               	add	x6, x4, x1
               	ldr	s2, [x6]
               	add	x6, x3, x1
               	ldr	s3, [x6]
               	fmov	s4, #1.00000000
               	fnmsub	s2, s2, s3, s4
               	fabs	s2, s2
               	fcmpe	s2, s0
               	b.le	<addr>
               	ldrsw	x6, [x2, #0x20]
               	orr	x6, x6, #0x10
               	str	w6, [x2, #0x20]
               	add	x6, x5, x1
               	ldr	s2, [x6]
               	sub	x6, x29, #0x60
               	add	x6, x6, x1
               	ldr	s3, [x6]
               	fmul	s2, s2, s3
               	sub	x6, x29, #0x80
               	add	x1, x6, x1
               	ldr	s3, [x1]
               	fmov	s4, #1.00000000
               	fnmsub	s2, s2, s3, s4
               	fabs	s2, s2
               	fcmpe	s2, s1
               	b.le	<addr>
               	ldrsw	x1, [x2, #0x20]
               	orr	x1, x1, #0x10
               	str	w1, [x2, #0x20]
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	ldp	x29, x30, [sp, #0xe0]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0xf0
               	ret
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w1, #0xff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
