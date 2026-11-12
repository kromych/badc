
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

<main>:
               	stp	d8, d9, [sp, #-0x120]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x26, x27, [sp, #0x40]
               	str	x28, [sp, #0x50]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x25, #0x0               // =0
               	mov	x24, #0x0               // =0
               	lsl	x26, x25, #15
               	add	x27, x25, #0x1
               	lsl	x0, x27, #15
               	mov	x17, #0x1357            // =4951
               	orr	x28, x0, x17
               	mov	x17, #0x26ae            // =9902
               	orr	x16, x26, x17
               	str	x16, [sp, #0xb8]
               	mov	x17, #0x3a05            // =14853
               	orr	x16, x0, x17
               	str	x16, [sp, #0xb0]
               	add	x21, x24, #0x78
               	add	x22, x24, #0x3f2
               	lsl	x1, x21, #23
               	orr	x0, x1, x26
               	stur	w0, [x29, #-0x28]
               	sub	x0, x29, #0x30
               	sub	x2, x29, #0x28
               	ldr	w16, [x2]
               	str	w16, [x0]
               	ldur	s0, [x29, #-0x30]
               	stur	s0, [x29, #-0x20]
               	orr	x3, x1, x28
               	stur	w3, [x29, #-0x28]
               	ldr	w16, [x2]
               	str	w16, [x0]
               	ldur	s0, [x29, #-0x30]
               	stur	s0, [x29, #-0x1c]
               	ldr	x17, [sp, #0xb8]
               	orr	x3, x1, x17
               	stur	w3, [x29, #-0x28]
               	ldr	w16, [x2]
               	str	w16, [x0]
               	ldur	s0, [x29, #-0x30]
               	stur	s0, [x29, #-0x18]
               	ldr	x17, [sp, #0xb0]
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x28]
               	ldr	w16, [x2]
               	str	w16, [x0]
               	ldur	s0, [x29, #-0x30]
               	stur	s0, [x29, #-0x14]
               	lsl	x1, x22, #52
               	orr	x2, x1, x25, lsl #44
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x2, x2, x17
               	stur	x2, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x30]
               	stur	d0, [x29, #-0x10]
               	orr	x0, x1, x27, lsl #44
               	mov	x17, #0xcf12            // =53010
               	movk	x17, #0x468a, lsl #16
               	movk	x17, #0x2, lsl #32
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x30
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x30]
               	stur	d0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	ldur	q2, [x29, #-0x10]
               	ldur	d3, [x29, #-0x8]
               	frecpe	v4.4s, v0.4s
               	stur	q4, [x29, #-0xb0]
               	frsqrte	v0.4s, v0.4s
               	stur	q0, [x29, #-0xa0]
               	stur	d1, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	fmov	d16, x0
               	frecpe	v0.2s, v16.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x50]
               	stur	d1, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	fmov	d16, x0
               	frsqrte	v0.2s, v16.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x48]
               	frecpe	v0.2d, v2.2d
               	stur	q0, [x29, #-0x90]
               	frsqrte	v0.2d, v2.2d
               	stur	q0, [x29, #-0x80]
               	stur	d3, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	fmov	d16, x0
               	frecpe	d0, d16
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x40]
               	ldur	d8, [x29, #-0x40]
               	stur	d3, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	fmov	d16, x0
               	frsqrte	d0, d16
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	ldur	d9, [x29, #-0x38]
               	mov	x20, #0x0               // =0
               	sub	x1, x29, #0x20
               	lsl	x0, x20, #2
               	add	x1, x1, x0
               	ldr	s0, [x1]
               	stur	s0, [x29, #-0x30]
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x30
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w3, [x29, #-0x28]
               	and	x3, x3, #0x7fffff
               	lsl	x3, x3, #29
               	sub	x4, x29, #0xb0
               	add	x4, x4, x0
               	ldr	s0, [x4]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w4, [x29, #-0x28]
               	lsr	x5, x3, #44
               	orr	x5, x5, #0x100
               	mov	x6, #0xfd               // =253
               	sub	x6, x6, x21
               	lsl	x5, x5, #1
               	add	x5, x5, #0x1
               	mov	x7, #0x80000            // =524288
               	sdiv	w5, w7, w5
               	add	x5, x5, #0x1
               	ubfx	x5, x5, #1, #8
               	lsl	x5, x5, #44
               	lsl	x6, x6, #23
               	orr	x5, x6, x5, lsr #29
               	cmp	w4, w5
               	b.eq	<addr>
               	adrp	x4, <page>
               	ldrsw	x5, [x4, #0x20]
               	orr	x5, x5, #0x1
               	str	w5, [x4, #0x20]
               	sub	x4, x29, #0xa0
               	add	x0, x4, x0
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w23, [x29, #-0x28]
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	mov	x2, x3
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x20
               	add	x1, x20, #0x2
               	add	x0, x0, x1, lsl #2
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x30]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x30
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	and	x2, x2, #0x7fffff
               	lsl	x2, x2, #29
               	sub	x4, x29, #0x50
               	lsl	x3, x20, #2
               	add	x4, x4, x3
               	ldr	s0, [x4]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w4, [x29, #-0x28]
               	lsr	x5, x2, #44
               	orr	x5, x5, #0x100
               	mov	x6, #0xfd               // =253
               	sub	x6, x6, x21
               	lsl	x5, x5, #1
               	add	x5, x5, #0x1
               	mov	x7, #0x80000            // =524288
               	sdiv	w5, w7, w5
               	add	x5, x5, #0x1
               	ubfx	x5, x5, #1, #8
               	lsl	x5, x5, #44
               	lsl	x6, x6, #23
               	orr	x5, x6, x5, lsr #29
               	cmp	w4, w5
               	b.eq	<addr>
               	adrp	x4, <page>
               	ldrsw	x5, [x4, #0x20]
               	orr	x5, x5, #0x1
               	str	w5, [x4, #0x20]
               	sub	x4, x29, #0x48
               	add	x3, x4, x3
               	ldr	s0, [x3]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w23, [x29, #-0x28]
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	sub	x1, x29, #0x10
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	d0, [x1]
               	stur	d0, [x29, #-0x28]
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x28
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x3, [x29, #-0x30]
               	and	x3, x3, #0xfffffffffffff
               	sub	x4, x29, #0x90
               	add	x4, x4, x0
               	ldr	d0, [x4]
               	stur	d0, [x29, #-0x28]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x4, [x29, #-0x30]
               	lsr	x5, x3, #44
               	orr	x5, x5, #0x100
               	mov	x6, #0x7fd              // =2045
               	sub	x6, x6, x22
               	lsl	x5, x5, #1
               	add	x5, x5, #0x1
               	mov	x7, #0x80000            // =524288
               	sdiv	w5, w7, w5
               	add	x5, x5, #0x1
               	ubfx	x5, x5, #1, #8
               	lsl	x6, x6, #52
               	orr	x5, x6, x5, lsl #44
               	cmp	x4, x5
               	b.eq	<addr>
               	adrp	x4, <page>
               	ldrsw	x5, [x4, #0x20]
               	orr	x5, x5, #0x1
               	str	w5, [x4, #0x20]
               	sub	x4, x29, #0x80
               	add	x0, x4, x0
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x28]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x23, [x29, #-0x30]
               	mov	x0, #0x40               // =64
               	mov	x1, x22
               	mov	x2, x3
               	bl	<addr>
               	cmp	x23, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	add	x20, x20, #0x1
               	cmp	w20, #0x2
               	b.lt	<addr>
               	ldur	d0, [x29, #-0x8]
               	stur	d0, [x29, #-0x28]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x28
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x2, [x29, #-0x30]
               	and	x2, x2, #0xfffffffffffff
               	stur	d8, [x29, #-0x28]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x3, [x29, #-0x30]
               	lsr	x4, x2, #44
               	orr	x4, x4, #0x100
               	mov	x5, #0x7fd              // =2045
               	sub	x5, x5, x22
               	lsl	x4, x4, #1
               	add	x4, x4, #0x1
               	mov	x6, #0x80000            // =524288
               	sdiv	w4, w6, w4
               	add	x4, x4, #0x1
               	ubfx	x4, x4, #1, #8
               	lsl	x5, x5, #52
               	orr	x4, x5, x4, lsl #44
               	cmp	x3, x4
               	b.eq	<addr>
               	adrp	x3, <page>
               	ldrsw	x4, [x3, #0x20]
               	orr	x4, x4, #0x1
               	str	w4, [x3, #0x20]
               	stur	d9, [x29, #-0x28]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x20, [x29, #-0x30]
               	mov	x0, #0x40               // =64
               	mov	x1, x22
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	add	x24, x24, #0x1
               	cmp	w24, #0x2
               	b.lt	<addr>
               	add	x25, x25, #0x2
               	cmp	w25, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	fmov	d17, x1
               	fmov	s0, s17
               	mov	x0, #0x80000000         // =2147483648
               	fmov	d17, x0
               	mov	v0.s[1], v17.s[0]
               	mov	x0, #0x7f800000         // =2139095040
               	fmov	d17, x0
               	mov	v0.s[2], v17.s[0]
               	mov	x0, #0xff800000         // =4286578688
               	fmov	d17, x0
               	mov	v1.16b, v0.16b
               	mov	v1.s[3], v17.s[0]
               	frecpe	v0.4s, v1.4s
               	frsqrte	v2.4s, v1.4s
               	mov	s1, v0.s[0]
               	stur	s1, [x29, #-0x30]
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x30
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w2, w17
               	b.ne	<addr>
               	mov	s1, v0.s[1]
               	stur	s1, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w2, w17
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x20]
               	orr	x3, x3, #0x1
               	str	w3, [x2, #0x20]
               	mov	s1, v0.s[2]
               	stur	s1, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	cbnz	w2, <addr>
               	mov	s0, v0.s[3]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w0, [x29, #-0x28]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x20]
               	stur	d0, [x29, #-0x30]
               	mov	x16, #0xc0400000        // =3225419776
               	movk	x16, #0x4040, lsl #48
               	str	x16, [sp, #0xa0]
               	ldr	d1, [sp, #0xa0]
               	frecpe	v0.2s, v1.2s
               	stur	d0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldur	x1, [x29, #-0x28]
               	stur	x1, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	stur	s0, [x29, #-0x30]
               	sub	x1, x29, #0x30
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x28]
               	stur	d0, [x29, #-0x30]
               	mov	x16, #0xc0400000        // =3225419776
               	movk	x16, #0x4040, lsl #48
               	str	x16, [sp, #0xa0]
               	ldr	d1, [sp, #0xa0]
               	frecpe	v0.2s, v1.2s
               	stur	d0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldur	x1, [x29, #-0x28]
               	stur	x1, [x29, #-0x8]
               	ldur	s0, [x29, #-0x4]
               	stur	s0, [x29, #-0x30]
               	sub	x1, x29, #0x30
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w3, [x29, #-0x28]
               	orr	x3, x3, #0x80000000
               	cmp	w2, w3
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x20]
               	orr	x3, x3, #0x1
               	str	w3, [x2, #0x20]
               	mov	s0, v2.s[0]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w2, w17
               	b.ne	<addr>
               	mov	s0, v2.s[1]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w2, [x29, #-0x28]
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w2, w17
               	b.ne	<addr>
               	mov	s0, v2.s[2]
               	stur	s0, [x29, #-0x30]
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w0, [x29, #-0x28]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	mov	s0, v2.s[3]
               	mov	x0, #0x0                // =0
               	fmov	s16, s0
               	fmov	d0, d16
               	mov	w0, v0.s[0]
               	ubfx	x0, x0, #23, #8
               	mov	w1, v0.s[0]
               	and	x1, x1, #0x7fffff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	w1, #0x0
               	csel	x0, x2, x0, ne
               	cbnz	w0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	frsqrte	v0.2d, v0.2d
               	mov	d0, v0.d[0]
               	mov	x0, v0.d[0]
               	ubfx	x0, x0, #52, #11
               	mov	x1, v0.d[0]
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x20]
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldr	q0, [x4]
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	ldr	q1, [x5]
               	frecps	v2.4s, v0.4s, v1.4s
               	sub	x6, x29, #0x90
               	stur	q2, [x29, #-0x90]
               	frsqrts	v2.4s, v0.4s, v1.4s
               	sub	x7, x29, #0x80
               	stur	q2, [x29, #-0x80]
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	frecps	v2.2s, v2.2s, v3.2s
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x18]
               	mov	d0, v0.d[1]
               	mov	d1, v1.d[1]
               	frsqrts	v0.2s, v0.2s, v1.2s
               	mov	x0, v0.d[0]
               	sub	x8, x29, #0x8
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	adrp	x9, <addr>
               	add	x9, x9, <lo12>
               	adrp	x2, <page>
               	lsl	x1, x0, #2
               	add	x3, x6, x1
               	ldr	s0, [x3]
               	add	x3, x4, x1
               	ldr	s1, [x3]
               	fneg	s1, s1
               	add	x10, x5, x1
               	ldr	s2, [x10]
               	fmov	s3, #2.00000000
               	fmadd	s1, s1, s2, s3
               	fcmp	s0, s1
               	b.eq	<addr>
               	ldrsw	x10, [x2, #0x20]
               	orr	x10, x10, #0x4
               	str	w10, [x2, #0x20]
               	add	x10, x7, x1
               	ldr	s0, [x10]
               	ldr	s1, [x3]
               	fneg	s1, s1
               	add	x1, x9, x1
               	ldr	s2, [x1]
               	fmov	s3, #3.00000000
               	fmadd	s1, s1, s2, s3
               	fmov	s2, #0.50000000
               	fmul	s1, s1, s2
               	fcmp	s0, s1
               	b.eq	<addr>
               	ldrsw	x1, [x2, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x2, #0x20]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	fmov	s0, w0
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	b	<addr>
               	sub	x4, x29, #0x18
               	smov	x1, v0.s[0]
               	lsl	x1, x1, #2
               	add	x4, x4, x1
               	ldr	s1, [x4]
               	add	x4, x2, x1
               	ldr	s2, [x4]
               	fneg	s2, s2
               	add	x1, x3, x1
               	ldr	s3, [x1]
               	fmov	s4, #2.00000000
               	fmadd	s2, s2, s3, s4
               	fcmp	s1, s2
               	b.eq	<addr>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	smov	x1, v0.s[0]
               	add	x4, x8, x1, lsl #2
               	ldr	s1, [x4]
               	add	x1, x1, #0x2
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x4, x2, x1
               	ldr	s2, [x4]
               	fneg	s2, s2
               	add	x1, x3, x1
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
               	smov	x1, v0.s[0]
               	add	x1, x1, #0x1
               	mov	v0.s[0], w1
               	smov	x1, v0.s[0]
               	cmp	x1, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0xb0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xa0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xa0]
               	frecps	v0.2d, v0.2d, v1.2d
               	sub	x5, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	sub	x6, x29, #0xb0
               	sub	x7, x29, #0xa0
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xa0]
               	frsqrts	v0.2d, v0.2d, v1.2d
               	sub	x8, x29, #0x80
               	stur	q0, [x29, #-0x80]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	lsl	x2, x0, #3
               	add	x3, x5, x2
               	ldr	d0, [x3]
               	add	x3, x6, x2
               	ldr	d1, [x3]
               	fneg	d1, d1
               	add	x4, x7, x2
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
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x60]
               	adrp	x0, <addr>
               	ldr	d1, [x0, #0x68]
               	frecps	d2, d0, d1
               	fneg	d3, d0
               	fmov	d4, #2.00000000
               	fmadd	d3, d3, d1, d4
               	fcmp	d2, d3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	frsqrts	d2, d0, d1
               	fneg	d0, d0
               	fmov	d3, #3.00000000
               	fmadd	d0, d0, d1, d3
               	fmov	d1, #0.50000000
               	fmul	d0, d0, d1
               	fcmp	d2, d0
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
               	mov	s2, v2.s[1]
               	fmov	s3, #2.00000000
               	fcmp	s2, s3
               	b.ne	<addr>
               	frecps	v2.4s, v1.4s, v0.4s
               	mov	s2, v2.s[2]
               	fmov	s3, #2.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	frsqrts	v2.4s, v0.4s, v1.4s
               	mov	s2, v2.s[1]
               	fmov	s3, #1.50000000
               	fcmp	s2, s3
               	b.ne	<addr>
               	frsqrts	v0.4s, v1.4s, v0.4s
               	mov	s0, v0.s[3]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	str	x16, [sp, #0xa0]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xa8]
               	ldr	d1, [sp, #0xa0]
               	ldr	d2, [sp, #0xa8]
               	frecps	d0, d1, d2
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x20]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xa0]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	str	x16, [sp, #0xa8]
               	ldr	d1, [sp, #0xa0]
               	ldr	d2, [sp, #0xa8]
               	frsqrts	d0, d1, d2
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0xa0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0xa0]
               	frecpe	v0.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	ldur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0x90]
               	frecps	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	sub	x3, x29, #0x90
               	ldur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0x90]
               	frecps	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	ldur	q0, [x29, #-0xa0]
               	frsqrte	v0.4s, v0.4s
               	stur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0xa0]
               	ldur	q0, [x29, #-0x80]
               	fmul	v1.4s, v1.4s, v0.4s
               	frsqrts	v0.4s, v1.4s, v0.4s
               	ldur	q1, [x29, #-0x80]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x80]
               	sub	x4, x29, #0x80
               	sub	x5, x29, #0xa0
               	ldur	q1, [x29, #-0xa0]
               	ldur	q0, [x29, #-0x80]
               	fmul	v1.4s, v1.4s, v0.4s
               	frsqrts	v0.4s, v1.4s, v0.4s
               	ldur	q1, [x29, #-0x80]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x80]
               	mov	x0, #0x0                // =0
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x80]
               	adrp	x16, <addr>
               	ldr	s1, [x16, #0x84]
               	adrp	x2, <page>
               	lsl	x1, x0, #2
               	add	x6, x3, x1
               	ldr	s2, [x6]
               	add	x6, x5, x1
               	ldr	s3, [x6]
               	fmov	s4, #1.00000000
               	fnmsub	s2, s2, s3, s4
               	fabs	s2, s2
               	fcmpe	s2, s0
               	b.le	<addr>
               	ldrsw	x6, [x2, #0x20]
               	orr	x6, x6, #0x10
               	str	w6, [x2, #0x20]
               	add	x6, x4, x1
               	ldr	s2, [x6]
               	sub	x6, x29, #0x80
               	add	x6, x6, x1
               	ldr	s3, [x6]
               	fmul	s2, s2, s3
               	sub	x6, x29, #0xa0
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
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x28, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x40]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x120
               	ret
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	b	<addr>
               	cmp	w0, #0xff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	w1, #0x0
               	csel	x0, x2, x0, ne
               	b	<addr>
