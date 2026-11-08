
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
               	tbz	w1, #0x0, <addr>
               	lsr	x2, x2, #45
               	orr	x2, x2, #0x80
               	cmp	w0, #0x20
               	b.ne	<addr>
               	mov	x3, #0x17c              // =380
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
               	mov	x3, #0xbfc              // =3068
               	b	<addr>
               	lsr	x2, x2, #44
               	orr	x2, x2, #0x100
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x110]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	mov	x26, #0x0               // =0
               	mov	x25, #0x0               // =0
               	add	x21, x25, #0x78
               	add	x23, x25, #0x3f2
               	lsl	x20, x21, #23
               	orr	x0, x20, x26, lsl #15
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	s0, [x29, #-0x38]
               	stur	s0, [x29, #-0x28]
               	add	x22, x26, #0x1
               	mov	x0, #0x1357             // =4951
               	orr	x0, x0, x22, lsl #15
               	orr	x0, x20, x0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	s0, [x29, #-0x38]
               	stur	s0, [x29, #-0x24]
               	mov	x0, #0x26ae             // =9902
               	orr	x0, x0, x26, lsl #15
               	orr	x0, x20, x0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	s0, [x29, #-0x38]
               	stur	s0, [x29, #-0x20]
               	mov	x0, #0x3a05             // =14853
               	orr	x0, x0, x22, lsl #15
               	orr	x0, x0, x21, lsl #23
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	s0, [x29, #-0x38]
               	stur	s0, [x29, #-0x1c]
               	lsl	x20, x23, #52
               	orr	x0, x20, x26, lsl #44
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	d0, [x29, #-0x38]
               	stur	d0, [x29, #-0x18]
               	add	x0, x26, #0x1
               	orr	x0, x20, x0, lsl #44
               	mov	x17, #0xcf12            // =53010
               	movk	x17, #0x468a, lsl #16
               	movk	x17, #0x2, lsl #32
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	d0, [x29, #-0x38]
               	stur	d0, [x29, #-0x10]
               	sub	x0, x29, #0x28
               	sub	x16, x29, #0x28
               	ldr	q0, [x16]
               	add	x0, x0, #0x8
               	ldr	d1, [x0]
               	stur	d1, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x68]
               	sub	x0, x29, #0x18
               	sub	x16, x29, #0x18
               	ldr	q1, [x16]
               	add	x0, x0, #0x8
               	ldr	d2, [x0]
               	stur	d2, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x60]
               	frecpe	v2.4s, v0.4s
               	stur	q2, [x29, #-0xc0]
               	frsqrte	v0.4s, v0.4s
               	stur	q0, [x29, #-0xb0]
               	sub	x0, x29, #0x68
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x38]
               	fmov	d16, x1
               	frecpe	v0.2s, v16.2s
               	stur	d0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x30]
               	stur	x1, [x29, #-0x58]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x38]
               	fmov	d16, x0
               	frsqrte	v0.2s, v16.2s
               	stur	d0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x50]
               	frecpe	v0.2d, v1.2d
               	stur	q0, [x29, #-0xa0]
               	frsqrte	v0.2d, v1.2d
               	stur	q0, [x29, #-0x90]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x38]
               	fmov	d16, x1
               	frecpe	d0, d16
               	stur	d0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x30]
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x38]
               	fmov	d16, x0
               	frsqrte	d0, d16
               	stur	d0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x40]
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x28
               	lsl	x22, x20, #2
               	add	x0, x0, x22
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	and	x0, x0, #0x7fffff
               	lsl	x24, x0, #29
               	sub	x0, x29, #0xc0
               	add	x0, x0, x22
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
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
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0xb0
               	add	x0, x0, x22
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w22, [x29, #-0x30]
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	mov	x2, x24
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x28
               	add	x1, x20, #0x2
               	add	x0, x0, x1, lsl #2
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	and	x0, x0, #0x7fffff
               	lsl	x22, x0, #29
               	sub	x0, x29, #0x58
               	lsl	x24, x20, #2
               	add	x0, x0, x24
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	lsr	x1, x22, #44
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
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x50
               	add	x0, x0, x24
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w24, [x29, #-0x30]
               	mov	x0, #0x20               // =32
               	mov	x1, x21
               	mov	x2, x22
               	bl	<addr>
               	cmp	x24, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x18
               	lsl	x22, x20, #3
               	add	x0, x0, x22
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x38]
               	and	x24, x0, #0xfffffffffffff
               	sub	x0, x29, #0xa0
               	add	x0, x0, x22
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x0, [x29, #-0x38]
               	lsr	x1, x24, #44
               	orr	x1, x1, #0x100
               	mov	x2, #0x7fd              // =2045
               	sub	x2, x2, x23
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	mov	x3, #0x80000            // =524288
               	sdiv	w1, w3, w1
               	add	x1, x1, #0x1
               	ubfx	x1, x1, #1, #8
               	lsl	x2, x2, #52
               	orr	x1, x2, x1, lsl #44
               	cmp	x0, x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x90
               	add	x0, x0, x22
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	ldur	x22, [x29, #-0x38]
               	mov	x0, #0x40               // =64
               	mov	x1, x23
               	mov	x2, x24
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	add	x20, x20, #0x1
               	cmp	w20, #0x2
               	b.lt	<addr>
               	ldur	d0, [x29, #-0x10]
               	stur	d0, [x29, #-0x8]
               	sub	x20, x29, #0x38
               	sub	x21, x29, #0x8
               	mov	x2, #0x8                // =8
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldur	x0, [x29, #-0x38]
               	and	x22, x0, #0xfffffffffffff
               	ldur	d0, [x29, #-0x48]
               	stur	d0, [x29, #-0x8]
               	mov	x24, #0x8               // =8
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	ldur	x0, [x29, #-0x38]
               	lsr	x1, x22, #44
               	orr	x1, x1, #0x100
               	mov	x2, #0x7fd              // =2045
               	sub	x2, x2, x23
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	mov	x3, #0x80000            // =524288
               	sdiv	w1, w3, w1
               	add	x1, x1, #0x1
               	ubfx	x1, x1, #1, #8
               	lsl	x2, x2, #52
               	orr	x1, x2, x1, lsl #44
               	cmp	x0, x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	ldur	d0, [x29, #-0x40]
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x8
               	mov	x2, x24
               	bl	<addr>
               	ldur	x20, [x29, #-0x38]
               	mov	x0, #0x40               // =64
               	mov	x1, x23
               	mov	x2, x22
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	add	x25, x25, #0x1
               	cmp	w25, #0x2
               	b.lt	<addr>
               	add	x26, x26, #0x2
               	cmp	w26, #0x100
               	b.lt	<addr>
               	sub	x0, x29, #0x90
               	stp	xzr, xzr, [x0]
               	stur	wzr, [x29, #-0x90]
               	mov	x16, #0x80000000        // =2147483648
               	fmov	s0, w16
               	stur	s0, [x29, #-0x8c]
               	mov	x16, #0x7f800000        // =2139095040
               	fmov	s0, w16
               	stur	s0, [x29, #-0x88]
               	mov	x16, #0xff800000        // =4286578688
               	fmov	s0, w16
               	stur	s0, [x29, #-0x84]
               	ldur	q0, [x29, #-0x90]
               	frecpe	v0.4s, v0.4s
               	stur	q0, [x29, #-0xa0]
               	ldur	q0, [x29, #-0x90]
               	frsqrte	v0.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	ldur	s0, [x29, #-0xa0]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	ldur	s0, [x29, #-0x98]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	cbnz	w0, <addr>
               	ldur	s0, [x29, #-0x94]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0x10
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x38]
               	fmov	d16, x0
               	frecpe	v0.2s, v16.2s
               	stur	d0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	ldur	x1, [x29, #-0x30]
               	stur	x1, [x29, #-0x10]
               	ldur	s0, [x29, #-0x10]
               	stur	s0, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w20, [x29, #-0x30]
               	sub	x0, x29, #0x10
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x38]
               	fmov	d16, x0
               	frecpe	v0.2s, v16.2s
               	stur	d0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	ldur	x1, [x29, #-0x30]
               	stur	x1, [x29, #-0x10]
               	ldur	s0, [x29, #-0xc]
               	stur	s0, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	orr	x0, x0, #0x80000000
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	ldur	s0, [x29, #-0x90]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	mov	x17, #0x7f800000        // =2139095040
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	mov	x17, #0xff800000        // =4286578688
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	stur	s0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x38
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x30]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	ldur	s0, [x29, #-0x84]
               	stur	s0, [x29, #-0x30]
               	ldur	w0, [x29, #-0x30]
               	ubfx	x1, x0, #23, #8
               	and	x0, x0, #0x7fffff
               	cbnz	w1, <addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x90
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0x90]
               	frsqrte	v0.2d, v0.2d
               	stur	q0, [x29, #-0x90]
               	ldur	d0, [x29, #-0x90]
               	stur	d0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x2
               	str	w1, [x0, #0x30]
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q1, [x16]
               	frecps	v2.4s, v0.4s, v1.4s
               	sub	x5, x29, #0xa0
               	stur	q2, [x29, #-0xa0]
               	frsqrts	v2.4s, v0.4s, v1.4s
               	sub	x6, x29, #0x90
               	stur	q2, [x29, #-0x90]
               	mov	d2, v0.d[0]
               	stur	d2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	d2, v1.d[0]
               	stur	d2, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	stur	x0, [x29, #-0x38]
               	stur	x1, [x29, #-0x30]
               	fmov	d16, x0
               	fmov	d17, x1
               	frecps	v2.2s, v16.2s, v17.2s
               	stur	d2, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x40]
               	mov	d0, v0.d[1]
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	d0, v1.d[1]
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	stur	x0, [x29, #-0x38]
               	stur	x1, [x29, #-0x30]
               	fmov	d16, x0
               	fmov	d17, x1
               	frsqrts	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	sub	x7, x29, #0x10
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	lsl	x0, x1, #2
               	add	x2, x5, x0
               	ldr	s0, [x2]
               	add	x2, x3, x0
               	ldr	s1, [x2]
               	fneg	s1, s1
               	add	x2, x4, x0
               	ldr	s2, [x2]
               	fmov	s3, #2.00000000
               	fmadd	s1, s1, s2, s3
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x2, <page>
               	ldrsw	x8, [x2, #0x30]
               	orr	x8, x8, #0x4
               	str	w8, [x2, #0x30]
               	add	x2, x6, x0
               	ldr	s0, [x2]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x2, x2, x0
               	ldr	s1, [x2]
               	fneg	s1, s1
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x0, x2, x0
               	ldr	s2, [x0]
               	fmov	s3, #3.00000000
               	fmadd	s1, s1, s2, s3
               	fmov	s2, #0.50000000
               	fmul	s1, s1, s2
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x30]
               	orr	x2, x2, #0x8
               	str	w2, [x0, #0x30]
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x40
               	lsl	x1, x0, #2
               	add	x2, x2, x1
               	ldr	s0, [x2]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x3, x2, x1
               	ldr	s1, [x3]
               	fneg	s1, s1
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	add	x4, x3, x1
               	ldr	s2, [x4]
               	fmov	s3, #2.00000000
               	fmadd	s1, s1, s2, s3
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x4, <page>
               	ldrsw	x5, [x4, #0x30]
               	orr	x5, x5, #0x4
               	str	w5, [x4, #0x30]
               	add	x1, x7, x1
               	ldr	s0, [x1]
               	add	x1, x0, #0x2
               	lsl	x1, x1, #2
               	add	x2, x2, x1
               	ldr	s1, [x2]
               	fneg	s1, s1
               	add	x1, x3, x1
               	ldr	s2, [x1]
               	fmov	s3, #3.00000000
               	fmadd	s1, s1, s2, s3
               	fmov	s2, #0.50000000
               	fmul	s1, s1, s2
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x30]
               	orr	x2, x2, #0x8
               	str	w2, [x1, #0x30]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xb0]
               	frecps	v0.2d, v0.2d, v1.2d
               	sub	x5, x29, #0xa0
               	stur	q0, [x29, #-0xa0]
               	sub	x6, x29, #0xc0
               	sub	x7, x29, #0xb0
               	ldur	q0, [x29, #-0xc0]
               	ldur	q1, [x29, #-0xb0]
               	frsqrts	v0.2d, v0.2d, v1.2d
               	sub	x8, x29, #0x90
               	stur	q0, [x29, #-0x90]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x2, x5, x1
               	ldr	d0, [x2]
               	add	x2, x6, x1
               	ldr	d1, [x2]
               	fneg	d1, d1
               	add	x3, x7, x1
               	ldr	d2, [x3]
               	fmov	d3, #2.00000000
               	fmadd	d1, d1, d2, d3
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x4, <page>
               	ldrsw	x9, [x4, #0x30]
               	orr	x9, x9, #0x4
               	str	w9, [x4, #0x30]
               	add	x1, x8, x1
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	fneg	d1, d1
               	ldr	d2, [x3]
               	fmov	d3, #3.00000000
               	fmadd	d1, d1, d2, d3
               	fmov	d2, #0.50000000
               	fmul	d1, d1, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x30]
               	orr	x2, x2, #0x8
               	str	w2, [x1, #0x30]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x2000000          // =33554432
               	movk	x0, #0x3ff0, lsl #48
               	stur	x0, [x29, #-0x48]
               	sub	x1, x29, #0x40
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	stur	x0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x2, [x29, #-0x30]
               	mov	x16, #0x2000000         // =33554432
               	movk	x16, #0x3ff0, lsl #48
               	str	x16, [sp, #0x80]
               	fmov	d16, x2
               	str	d16, [sp, #0x88]
               	ldr	d1, [sp, #0x80]
               	ldr	d2, [sp, #0x88]
               	frecps	d0, d1, d2
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	ldur	d1, [x29, #-0x48]
               	fneg	d1, d1
               	sub	x1, x29, #0x40
               	ldur	d2, [x29, #-0x40]
               	fmov	d3, #2.00000000
               	fmadd	d1, d1, d2, d3
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x30]
               	orr	x2, x2, #0x4
               	str	w2, [x0, #0x30]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x38]
               	ldur	x1, [x29, #-0x30]
               	fmov	d16, x0
               	fmov	d17, x1
               	frsqrts	d0, d16, d17
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	ldur	d1, [x29, #-0x48]
               	fneg	d1, d1
               	ldur	d2, [x29, #-0x40]
               	fmov	d3, #3.00000000
               	fmadd	d1, d1, d2, d3
               	fmov	d2, #0.50000000
               	fmul	d1, d1, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x30]
               	mov	x16, #0x7f800000        // =2139095040
               	str	x16, [sp, #0x80]
               	ldr	d1, [sp, #0x80]
               	dup	v0.4s, v1.s[0]
               	mov	v2.16b, v0.16b
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x80]
               	ldr	d1, [sp, #0x80]
               	dup	v0.4s, v1.s[0]
               	frecps	v1.4s, v2.4s, v0.4s
               	stur	q1, [x29, #-0x90]
               	ldur	s1, [x29, #-0x8c]
               	fmov	s3, #2.00000000
               	fcmp	s1, s3
               	b.ne	<addr>
               	frecps	v1.4s, v0.4s, v2.4s
               	stur	q1, [x29, #-0x90]
               	ldur	s1, [x29, #-0x88]
               	fmov	s3, #2.00000000
               	fcmp	s1, s3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x30]
               	frsqrts	v1.4s, v2.4s, v0.4s
               	stur	q1, [x29, #-0x90]
               	ldur	s1, [x29, #-0x8c]
               	fmov	s3, #1.50000000
               	fcmp	s1, s3
               	b.ne	<addr>
               	frsqrts	v0.4s, v0.4s, v2.4s
               	stur	q0, [x29, #-0x90]
               	ldur	s0, [x29, #-0x84]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x30]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x10
               	str	xzr, [x0]
               	stur	d0, [x29, #-0x38]
               	sub	x1, x29, #0x30
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x38]
               	fmov	d16, x1
               	str	d16, [sp, #0x80]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x88]
               	ldr	d1, [sp, #0x80]
               	ldr	d2, [sp, #0x88]
               	frecps	d0, d1, d2
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x4
               	str	w1, [x0, #0x30]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	stur	xzr, [x29, #-0x38]
               	stur	d0, [x29, #-0x30]
               	ldur	x2, [x29, #-0x30]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x80]
               	fmov	d16, x2
               	str	d16, [sp, #0x88]
               	ldr	d1, [sp, #0x80]
               	ldr	d2, [sp, #0x88]
               	frsqrts	d0, d1, d2
               	stur	d0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	orr	x1, x1, #0x8
               	str	w1, [x0, #0x30]
               	sub	x0, x29, #0xb0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	q0, [x29, #-0xb0]
               	frecpe	v0.4s, v0.4s
               	stur	q0, [x29, #-0xa0]
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xa0]
               	frecps	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0xa0]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0xa0]
               	sub	x3, x29, #0xa0
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xa0]
               	frecps	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0xa0]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0xa0]
               	ldur	q0, [x29, #-0xb0]
               	frsqrte	v0.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x90]
               	frsqrts	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	sub	x4, x29, #0xb0
               	ldur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v0.4s, v1.4s
               	sub	x5, x29, #0x90
               	ldur	q1, [x29, #-0x90]
               	frsqrts	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x90]
               	fmul	v0.4s, v1.4s, v0.4s
               	stur	q0, [x29, #-0x90]
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #2
               	add	x2, x3, x1
               	ldr	s0, [x2]
               	add	x2, x4, x1
               	ldr	s1, [x2]
               	fmov	s2, #1.00000000
               	fnmsub	s0, s0, s1, s2
               	fabs	s0, s0
               	adrp	x16, <addr>
               	ldr	s1, [x16, #0x78]
               	fcmpe	s0, s1
               	b.le	<addr>
               	adrp	x2, <page>
               	ldrsw	x6, [x2, #0x30]
               	orr	x6, x6, #0x10
               	str	w6, [x2, #0x30]
               	add	x2, x5, x1
               	ldr	s0, [x2]
               	sub	x2, x29, #0x90
               	add	x2, x2, x1
               	ldr	s1, [x2]
               	fmul	s0, s0, s1
               	sub	x2, x29, #0xb0
               	add	x1, x2, x1
               	ldr	s1, [x1]
               	fmov	s2, #1.00000000
               	fnmsub	s0, s0, s1, s2
               	fabs	s0, s0
               	adrp	x16, <addr>
               	ldr	s1, [x16, #0x7c]
               	fcmpe	s0, s1
               	b.le	<addr>
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x30]
               	orr	x2, x2, #0x10
               	str	w2, [x1, #0x30]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x30]
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0xff
               	b.ne	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
