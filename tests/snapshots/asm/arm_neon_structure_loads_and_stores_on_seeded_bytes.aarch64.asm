
arm_neon_structure_loads_and_stores_on_seeded_bytes.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1b3              // =435
               	movk	x4, #0x100, lsl #32
               	adrp	x3, <page>
               	cmp	x2, x1
               	b.hs	<addr>
               	ldr	x5, [x3, #0x18]
               	ldrb	w6, [x0, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x4
               	str	x5, [x3, #0x18]
               	add	x2, x2, #0x1
               	cmp	x2, x1
               	b.lo	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x5               // =5
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	sub	sp, sp, #0xb20
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	mov	x21, #0x0               // =0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x1, x2, #0xff
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x200              // =512
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x4310]
               	str	d0, [sp, #0x4318]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x480
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x480
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrsb	x1, [x0, #0x3]
               	ldr	x16, [sp, #0x4100]
               	and	x2, x16, #0xffffffffffffff00
               	and	x3, x1, #0xff
               	orr	x2, x2, x3
               	and	x2, x2, #0xffffffffffff00ff
               	and	x3, x1, #0xff
               	orr	x2, x2, x3, lsl #8
               	and	x2, x2, #0xffffffffff00ffff
               	and	x3, x1, #0xff
               	orr	x2, x2, x3, lsl #16
               	and	x2, x2, #0xffffffff00ffffff
               	and	x1, x1, #0xff
               	orr	x2, x2, x1, lsl #24
               	ldrsb	x1, [x0, #0x3]
               	and	x2, x2, #0xffffff00ffffffff
               	and	x3, x1, #0xff
               	orr	x2, x2, x3, lsl #32
               	and	x2, x2, #0xffff00ffffffffff
               	and	x3, x1, #0xff
               	orr	x2, x2, x3, lsl #40
               	and	x2, x2, #0xff00ffffffffffff
               	and	x3, x1, #0xff
               	orr	x2, x2, x3, lsl #48
               	and	x2, x2, #0xffffffffffffff
               	orr	x2, x2, x1, lsl #56
               	ldrsb	x1, [x0, #0x4]
               	ldr	x16, [sp, #0x40f8]
               	and	x3, x16, #0xffffffffffffff00
               	and	x5, x1, #0xff
               	orr	x3, x3, x5
               	and	x3, x3, #0xffffffffffff00ff
               	and	x5, x1, #0xff
               	orr	x3, x3, x5, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	and	x5, x1, #0xff
               	orr	x3, x3, x5, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	and	x1, x1, #0xff
               	orr	x3, x3, x1, lsl #24
               	ldrsb	x1, [x0, #0x4]
               	and	x3, x3, #0xffffff00ffffffff
               	and	x5, x1, #0xff
               	orr	x3, x3, x5, lsl #32
               	and	x3, x3, #0xffff00ffffffffff
               	and	x5, x1, #0xff
               	orr	x3, x3, x5, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	and	x5, x1, #0xff
               	orr	x3, x3, x5, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x1, x3, x1, lsl #56
               	str	x2, [sp, #0x4330]
               	str	x1, [sp, #0x4338]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x810
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x7d0
               	str	x2, [sp, #0x4100]
               	str	x1, [sp, #0x40f8]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0x5
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7d0
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7d0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x7e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7e0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x450
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4340]
               	ldr	d1, [sp, #0x4348]
               	zip1	v0.8b, v0.8b, v1.8b
               	str	d0, [x4]
               	ldr	d0, [sp, #0x46d0]
               	ldr	d1, [sp, #0x46d8]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x7f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x440
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x440
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x800
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x7c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7c0
               	lsl	x3, x0, #3
               	ldrsb	x2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x810
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x800
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xda8
               	add	x4, x0, x0, lsl #1
               	ldrsb	x4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xda8
               	add	x3, x3, #0x8
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrsb	x4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xda8
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrsb	x4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4d78]
               	ldr	x3, [sp, #0x4d80]
               	ldr	x4, [sp, #0x4d88]
               	str	x0, [sp, #0x4850]
               	str	x3, [sp, #0x4858]
               	str	x4, [sp, #0x4860]
               	add	x0, x1, #0x1
               	sub	x3, x29, #0xdf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x0, x29, #0xdf0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x2b8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrsb	x0, [x1, #0x3]
               	ldr	x16, [sp, #0x4118]
               	and	x3, x16, #0xffffffffffffff00
               	and	x4, x0, #0xff
               	orr	x3, x3, x4
               	and	x3, x3, #0xffffffffffff00ff
               	and	x4, x0, #0xff
               	orr	x3, x3, x4, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	and	x4, x0, #0xff
               	orr	x3, x3, x4, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	and	x0, x0, #0xff
               	orr	x3, x3, x0, lsl #24
               	ldrsb	x0, [x1, #0x3]
               	and	x3, x3, #0xffffff00ffffffff
               	and	x4, x0, #0xff
               	orr	x3, x3, x4, lsl #32
               	and	x3, x3, #0xffff00ffffffffff
               	and	x4, x0, #0xff
               	orr	x3, x3, x4, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	and	x4, x0, #0xff
               	orr	x3, x3, x4, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x3, x3, x0, lsl #56
               	ldrsb	x0, [x1, #0x4]
               	ldr	x16, [sp, #0x4110]
               	and	x4, x16, #0xffffffffffffff00
               	and	x5, x0, #0xff
               	orr	x4, x4, x5
               	and	x4, x4, #0xffffffffffff00ff
               	and	x5, x0, #0xff
               	orr	x4, x4, x5, lsl #8
               	and	x4, x4, #0xffffffffff00ffff
               	and	x5, x0, #0xff
               	orr	x4, x4, x5, lsl #16
               	and	x4, x4, #0xffffffff00ffffff
               	and	x0, x0, #0xff
               	orr	x4, x4, x0, lsl #24
               	ldrsb	x0, [x1, #0x4]
               	and	x4, x4, #0xffffff00ffffffff
               	and	x5, x0, #0xff
               	orr	x4, x4, x5, lsl #32
               	and	x4, x4, #0xffff00ffffffffff
               	and	x5, x0, #0xff
               	orr	x4, x4, x5, lsl #40
               	and	x4, x4, #0xff00ffffffffffff
               	and	x5, x0, #0xff
               	orr	x4, x4, x5, lsl #48
               	and	x4, x4, #0xffffffffffffff
               	orr	x4, x4, x0, lsl #56
               	ldrsb	x0, [x1, #0x5]
               	ldr	x16, [sp, #0x4108]
               	and	x5, x16, #0xffffffffffffff00
               	and	x6, x0, #0xff
               	orr	x5, x5, x6
               	and	x5, x5, #0xffffffffffff00ff
               	and	x6, x0, #0xff
               	orr	x5, x5, x6, lsl #8
               	and	x5, x5, #0xffffffffff00ffff
               	and	x6, x0, #0xff
               	orr	x5, x5, x6, lsl #16
               	and	x5, x5, #0xffffffff00ffffff
               	and	x0, x0, #0xff
               	orr	x5, x5, x0, lsl #24
               	ldrsb	x0, [x1, #0x5]
               	and	x5, x5, #0xffffff00ffffffff
               	and	x6, x0, #0xff
               	orr	x5, x5, x6, lsl #32
               	and	x5, x5, #0xffff00ffffffffff
               	and	x6, x0, #0xff
               	orr	x5, x5, x6, lsl #40
               	and	x5, x5, #0xff00ffffffffffff
               	and	x6, x0, #0xff
               	orr	x5, x5, x6, lsl #48
               	and	x5, x5, #0xffffffffffffff
               	orr	x0, x5, x0, lsl #56
               	str	x3, [sp, #0x4880]
               	str	x4, [sp, #0x4888]
               	str	x0, [sp, #0x4890]
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x2d0
               	sub	x6, x29, #0x1, lsl #12  // =0x1000
               	sub	x6, x6, #0x270
               	str	x3, [sp, #0x4118]
               	str	x4, [sp, #0x4110]
               	str	x0, [sp, #0x4108]
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x6]
               	ldr	x16, [x5, #0x10]
               	str	x16, [x6, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x270
               	add	x1, x1, x0, lsl #3
               	ldrsb	x3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x270
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x288
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x288
               	sub	x1, x29, #0xd90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0xd90
               	ldrsb	x3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0xd90
               	add	x3, x3, #0x8
               	ldrsb	x3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0xd90
               	add	x3, x3, #0x10
               	ldrsb	x3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x18
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2a0
               	sub	x3, x29, #0xd78
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x1, x29, #0xd78
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2b8
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x258
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x258
               	lsl	x2, x0, #3
               	ldrsb	x1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2d0
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2b8
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x4fa0]
               	str	d5, [sp, #0x4fa8]
               	str	d1, [sp, #0x4fb0]
               	str	d0, [sp, #0x4fb8]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x420
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x420
               	sub	x1, x29, #0xb60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x360
               	lsl	x3, x0, #3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x360
               	add	x2, x2, x0, lsl #3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x57c0]
               	ldr	x1, [sp, #0x57c8]
               	ldr	x2, [sp, #0x57d0]
               	ldr	x3, [sp, #0x57d8]
               	str	x0, [sp, #0x4fe0]
               	str	x1, [sp, #0x4fe8]
               	str	x2, [sp, #0x4ff0]
               	str	x3, [sp, #0x4ff8]
               	sub	x0, x29, #0xb80
               	sub	x1, x29, #0xb00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xb00
               	add	x1, x1, x0, lsl #3
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xb00
               	sub	x1, x29, #0xb20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0xb20
               	sub	x1, x29, #0x340
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5000]
               	ldr	d1, [sp, #0x5010]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldr	d1, [sp, #0x57e0]
               	ldr	d2, [sp, #0x57f0]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldr	d2, [sp, #0x57e8]
               	ldr	d3, [sp, #0x57f8]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	str	d3, [x6]
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [x6, #0x8]
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x10]
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x18]
               	add	x0, x6, #0x20
               	sub	x1, x29, #0xb40
               	sub	x2, x29, #0x320
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x320
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0xb60
               	sub	x1, x29, #0xae0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xae0
               	lsl	x3, x0, #3
               	ldrsb	x2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xb80
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0xb60
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x24a0]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x24b0]
               	str	q2, [sp, #0x50]
               	str	q0, [sp, #0x60]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xaa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xaa0
               	add	x1, sp, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	lsl	x3, x0, #4
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x24c0]
               	ldr	q1, [sp, #0x24d0]
               	str	q0, [sp, #0x90]
               	str	q1, [sp, #0xa0]
               	add	x0, sp, #0x50
               	add	x1, sp, #0xb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xb0
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0xb0
               	add	x1, sp, #0xd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xd0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x640
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xd0]
               	ldr	q1, [sp, #0xe0]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x24e0]
               	ldr	q1, [sp, #0x24f0]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x0, x6, #0x20
               	add	x1, sp, #0x90
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x620
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x620
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0x70
               	add	x1, sp, #0xf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xf0
               	lsl	x3, x0, #4
               	ldrsb	x2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x50
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x70
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x600
               	add	x4, x0, x0, lsl #1
               	ldrsb	x4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x600
               	add	x1, x1, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrsb	x4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x600
               	add	x1, x1, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrsb	x4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2520]
               	ldr	q1, [sp, #0x2530]
               	ldr	q2, [sp, #0x2540]
               	str	q0, [sp, #0x110]
               	str	q1, [sp, #0x120]
               	str	q2, [sp, #0x130]
               	add	x0, x2, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa80
               	add	x1, sp, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x2, #0x3
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	lsl	x5, x0, #4
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x4, x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x1]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x2]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x3]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x4]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x6]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x7]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x8]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0x9]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xa]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xb]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xc]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xd]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xe]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x5d0
               	add	x4, x4, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x4, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2550]
               	ldr	q1, [sp, #0x2560]
               	ldr	q2, [sp, #0x2570]
               	str	q0, [sp, #0x170]
               	str	q1, [sp, #0x180]
               	str	q2, [sp, #0x190]
               	add	x0, sp, #0x110
               	add	x1, sp, #0x1a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x4, x2, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x1a0
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x4, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, sp, #0x1a0
               	add	x1, sp, #0x1d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x1d0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x5a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x5a0
               	ldrsb	x2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x5a0
               	add	x2, x2, #0x10
               	ldrsb	x2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x5a0
               	add	x2, x2, #0x20
               	ldrsb	x2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x0, x3, #0x30
               	add	x1, sp, #0x170
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x570
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x570
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0x140
               	add	x1, sp, #0x200
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x200
               	lsl	x2, x0, #4
               	ldrsb	x1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x110
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x140
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x25e0]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x25f0]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x2600]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x2610]
               	str	q3, [sp, #0x230]
               	str	q5, [sp, #0x240]
               	str	q1, [sp, #0x250]
               	str	q0, [sp, #0x260]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xa50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa50
               	add	x1, sp, #0x270
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	lsl	x3, x0, #4
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x500
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2620]
               	ldr	q1, [sp, #0x2630]
               	ldr	q2, [sp, #0x2640]
               	ldr	q3, [sp, #0x2650]
               	str	q0, [sp, #0x2b0]
               	str	q1, [sp, #0x2c0]
               	str	q2, [sp, #0x2d0]
               	str	q3, [sp, #0x2e0]
               	add	x0, sp, #0x230
               	add	x1, sp, #0x2f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x2f0
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x0, sp, #0x2f0
               	add	x1, sp, #0x330
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x330
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x4c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x330]
               	ldr	q1, [sp, #0x350]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x2660]
               	ldr	q2, [sp, #0x2680]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x2670]
               	ldr	q3, [sp, #0x2690]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x0, x6, #0x40
               	add	x1, sp, #0x2b0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x480
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x480
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0x270
               	add	x1, sp, #0x370
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x6, #0x80
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0x370
               	lsl	x3, x0, #4
               	ldrsb	x2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x230
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x270
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x4370]
               	str	d0, [sp, #0x4378]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x470
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w1, [x0, #0x3]
               	ldr	x16, [sp, #0x4128]
               	and	x2, x16, #0xffffffffffffff00
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffffffff00ff
               	orr	x2, x2, x1, lsl #8
               	and	x2, x2, #0xffffffffff00ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffffffff00ffffff
               	orr	x2, x2, x1, lsl #24
               	and	x2, x2, #0xffffff00ffffffff
               	orr	x2, x2, x1, lsl #32
               	ldrb	w1, [x0, #0x3]
               	and	x2, x2, #0xffff00ffffffffff
               	orr	x2, x2, x1, lsl #40
               	and	x2, x2, #0xff00ffffffffffff
               	orr	x2, x2, x1, lsl #48
               	and	x2, x2, #0xffffffffffffff
               	orr	x2, x2, x1, lsl #56
               	ldrb	w1, [x0, #0x4]
               	ldr	x16, [sp, #0x4120]
               	and	x3, x16, #0xffffffffffffff00
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffffffff00ff
               	orr	x3, x3, x1, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	orr	x3, x3, x1, lsl #24
               	and	x3, x3, #0xffffff00ffffffff
               	orr	x3, x3, x1, lsl #32
               	ldrb	w1, [x0, #0x4]
               	and	x3, x3, #0xffff00ffffffffff
               	orr	x3, x3, x1, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	orr	x3, x3, x1, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x1, x3, x1, lsl #56
               	str	x2, [sp, #0x4390]
               	str	x1, [sp, #0x4398]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x7b0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x770
               	str	x2, [sp, #0x4128]
               	str	x1, [sp, #0x4120]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0x5
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x770
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x770
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x780
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x780
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x430
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x43a0]
               	ldr	d1, [sp, #0x43a8]
               	zip1	v0.8b, v0.8b, v1.8b
               	str	d0, [x4]
               	ldr	d0, [sp, #0x46f0]
               	ldr	d1, [sp, #0x46f8]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x790
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x420
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x420
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7a0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x760
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x760
               	lsl	x3, x0, #3
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7b0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x7a0
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xd60
               	add	x4, x0, x0, lsl #1
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xd60
               	add	x3, x3, #0x8
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xd60
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4dc0]
               	ldr	x3, [sp, #0x4dc8]
               	ldr	x4, [sp, #0x4dd0]
               	str	x0, [sp, #0x48e0]
               	str	x3, [sp, #0x48e8]
               	str	x4, [sp, #0x48f0]
               	add	x0, x1, #0x1
               	sub	x3, x29, #0xdd8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x0, x29, #0xdd8
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x228
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrb	w0, [x1, #0x3]
               	ldr	x16, [sp, #0x4140]
               	and	x3, x16, #0xffffffffffffff00
               	orr	x3, x3, x0
               	and	x3, x3, #0xffffffffffff00ff
               	orr	x3, x3, x0, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	orr	x3, x3, x0, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	orr	x3, x3, x0, lsl #24
               	and	x3, x3, #0xffffff00ffffffff
               	orr	x3, x3, x0, lsl #32
               	ldrb	w0, [x1, #0x3]
               	and	x3, x3, #0xffff00ffffffffff
               	orr	x3, x3, x0, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	orr	x3, x3, x0, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x3, x3, x0, lsl #56
               	ldrb	w0, [x1, #0x4]
               	ldr	x16, [sp, #0x4138]
               	and	x4, x16, #0xffffffffffffff00
               	orr	x4, x4, x0
               	and	x4, x4, #0xffffffffffff00ff
               	orr	x4, x4, x0, lsl #8
               	and	x4, x4, #0xffffffffff00ffff
               	orr	x4, x4, x0, lsl #16
               	and	x4, x4, #0xffffffff00ffffff
               	orr	x4, x4, x0, lsl #24
               	and	x4, x4, #0xffffff00ffffffff
               	orr	x4, x4, x0, lsl #32
               	ldrb	w0, [x1, #0x4]
               	and	x4, x4, #0xffff00ffffffffff
               	orr	x4, x4, x0, lsl #40
               	and	x4, x4, #0xff00ffffffffffff
               	orr	x4, x4, x0, lsl #48
               	and	x4, x4, #0xffffffffffffff
               	orr	x4, x4, x0, lsl #56
               	ldrb	w0, [x1, #0x5]
               	ldr	x16, [sp, #0x4130]
               	and	x5, x16, #0xffffffffffffff00
               	orr	x5, x5, x0
               	and	x5, x5, #0xffffffffffff00ff
               	orr	x5, x5, x0, lsl #8
               	and	x5, x5, #0xffffffffff00ffff
               	orr	x5, x5, x0, lsl #16
               	and	x5, x5, #0xffffffff00ffffff
               	orr	x5, x5, x0, lsl #24
               	and	x5, x5, #0xffffff00ffffffff
               	orr	x5, x5, x0, lsl #32
               	ldrb	w0, [x1, #0x5]
               	and	x5, x5, #0xffff00ffffffffff
               	orr	x5, x5, x0, lsl #40
               	and	x5, x5, #0xff00ffffffffffff
               	orr	x5, x5, x0, lsl #48
               	and	x5, x5, #0xffffffffffffff
               	orr	x0, x5, x0, lsl #56
               	str	x3, [sp, #0x4910]
               	str	x4, [sp, #0x4918]
               	str	x0, [sp, #0x4920]
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x240
               	sub	x6, x29, #0x1, lsl #12  // =0x1000
               	sub	x6, x6, #0x1e0
               	str	x3, [sp, #0x4140]
               	str	x4, [sp, #0x4138]
               	str	x0, [sp, #0x4130]
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x6]
               	ldr	x16, [x5, #0x10]
               	str	x16, [x6, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	add	x1, x1, x0, lsl #3
               	ldrb	w3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1e0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1f8
               	sub	x1, x29, #0xd48
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0xd48
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0xd48
               	add	x3, x3, #0x8
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0xd48
               	add	x3, x3, #0x10
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x18
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x210
               	sub	x3, x29, #0xd30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x1, x29, #0xd30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x228
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1c8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1c8
               	lsl	x2, x0, #3
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x240
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x228
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x5060]
               	str	d5, [sp, #0x5068]
               	str	d1, [sp, #0x5070]
               	str	d0, [sp, #0x5078]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x400
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x400
               	sub	x1, x29, #0xaa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x300
               	lsl	x3, x0, #3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x300
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x5820]
               	ldr	x1, [sp, #0x5828]
               	ldr	x2, [sp, #0x5830]
               	ldr	x3, [sp, #0x5838]
               	str	x0, [sp, #0x50a0]
               	str	x1, [sp, #0x50a8]
               	str	x2, [sp, #0x50b0]
               	str	x3, [sp, #0x50b8]
               	sub	x0, x29, #0xac0
               	sub	x1, x29, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xa40
               	add	x1, x1, x0, lsl #3
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa40
               	sub	x1, x29, #0xa60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0xa60
               	sub	x1, x29, #0x2e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x50c0]
               	ldr	d1, [sp, #0x50d0]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldr	d1, [sp, #0x5840]
               	ldr	d2, [sp, #0x5850]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldr	d2, [sp, #0x5848]
               	ldr	d3, [sp, #0x5858]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	str	d3, [x6]
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [x6, #0x8]
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x10]
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x18]
               	add	x0, x6, #0x20
               	sub	x1, x29, #0xa80
               	sub	x2, x29, #0x2c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0xaa0
               	sub	x1, x29, #0xa20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xa20
               	lsl	x3, x0, #3
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xac0
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0xaa0
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x26e0]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x26f0]
               	str	q2, [sp, #0x3b0]
               	str	q0, [sp, #0x3c0]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xa10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa10
               	add	x1, sp, #0x3d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x420
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2700]
               	ldr	q1, [sp, #0x2710]
               	str	q0, [sp, #0x3f0]
               	str	q1, [sp, #0x400]
               	add	x0, sp, #0x3b0
               	add	x1, sp, #0x410
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x410
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0x410
               	add	x1, sp, #0x430
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0x430
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x400
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x430]
               	ldr	q1, [sp, #0x440]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x2720]
               	ldr	q1, [sp, #0x2730]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x0, x6, #0x20
               	add	x1, sp, #0x3f0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0x3d0
               	add	x1, sp, #0x450
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0x450
               	lsl	x3, x0, #4
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x3b0
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x3d0
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3c0
               	add	x4, x0, x0, lsl #1
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3c0
               	add	x1, x1, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3c0
               	add	x1, x1, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2760]
               	ldr	q1, [sp, #0x2770]
               	ldr	q2, [sp, #0x2780]
               	str	q0, [sp, #0x470]
               	str	q1, [sp, #0x480]
               	str	q2, [sp, #0x490]
               	add	x0, x2, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x9f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x9f0
               	add	x1, sp, #0x4a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x2, #0x3
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	lsl	x5, x0, #4
               	ldrb	w6, [x1, x0]
               	strb	w6, [x4, x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x1]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x2]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x3]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x4]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x6]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x7]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x8]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x9]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xa]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xb]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xc]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xd]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xe]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x390
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2790]
               	ldr	q1, [sp, #0x27a0]
               	ldr	q2, [sp, #0x27b0]
               	str	q0, [sp, #0x4d0]
               	str	q1, [sp, #0x4e0]
               	str	q2, [sp, #0x4f0]
               	add	x0, sp, #0x470
               	add	x1, sp, #0x500
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x4, x2, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x500
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x4, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, sp, #0x500
               	add	x1, sp, #0x530
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x530
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x360
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x360
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x360
               	add	x2, x2, #0x10
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x360
               	add	x2, x2, #0x20
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x0, x3, #0x30
               	add	x1, sp, #0x4d0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x330
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x330
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0x4a0
               	add	x1, sp, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x560
               	lsl	x2, x0, #4
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x470
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x4a0
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x2820]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x2830]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x2840]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x2850]
               	str	q3, [sp, #0x590]
               	str	q5, [sp, #0x5a0]
               	str	q1, [sp, #0x5b0]
               	str	q0, [sp, #0x5c0]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x9c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x9c0
               	add	x1, sp, #0x5d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x2c0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2860]
               	ldr	q1, [sp, #0x2870]
               	ldr	q2, [sp, #0x2880]
               	ldr	q3, [sp, #0x2890]
               	str	q0, [sp, #0x610]
               	str	q1, [sp, #0x620]
               	str	q2, [sp, #0x630]
               	str	q3, [sp, #0x640]
               	add	x0, sp, #0x590
               	add	x1, sp, #0x650
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x650
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x0, sp, #0x650
               	add	x1, sp, #0x690
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x690
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x690]
               	ldr	q1, [sp, #0x6b0]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x28a0]
               	ldr	q2, [sp, #0x28c0]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x28b0]
               	ldr	q3, [sp, #0x28d0]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x0, x6, #0x40
               	add	x1, sp, #0x610
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0x5d0
               	add	x1, sp, #0x6d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x6, #0x80
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0x6d0
               	lsl	x3, x0, #4
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x590
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x5d0
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x43d0]
               	str	d0, [sp, #0x43d8]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x460
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x460
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x740
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w1, [x0, #0x3]
               	ldr	x16, [sp, #0x4150]
               	and	x2, x16, #0xffffffffffffff00
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffffffff00ff
               	orr	x2, x2, x1, lsl #8
               	and	x2, x2, #0xffffffffff00ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffffffff00ffffff
               	orr	x2, x2, x1, lsl #24
               	and	x2, x2, #0xffffff00ffffffff
               	orr	x2, x2, x1, lsl #32
               	ldrb	w1, [x0, #0x3]
               	and	x2, x2, #0xffff00ffffffffff
               	orr	x2, x2, x1, lsl #40
               	and	x2, x2, #0xff00ffffffffffff
               	orr	x2, x2, x1, lsl #48
               	and	x2, x2, #0xffffffffffffff
               	orr	x2, x2, x1, lsl #56
               	ldrb	w1, [x0, #0x4]
               	ldr	x16, [sp, #0x4148]
               	and	x3, x16, #0xffffffffffffff00
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffffffff00ff
               	orr	x3, x3, x1, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	orr	x3, x3, x1, lsl #24
               	and	x3, x3, #0xffffff00ffffffff
               	orr	x3, x3, x1, lsl #32
               	ldrb	w1, [x0, #0x4]
               	and	x3, x3, #0xffff00ffffffffff
               	orr	x3, x3, x1, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	orr	x3, x3, x1, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x1, x3, x1, lsl #56
               	str	x2, [sp, #0x43f0]
               	str	x1, [sp, #0x43f8]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x750
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x710
               	str	x2, [sp, #0x4150]
               	str	x1, [sp, #0x4148]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0x5
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x710
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x710
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x720
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x720
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x410
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4400]
               	ldr	d1, [sp, #0x4408]
               	zip1	v0.8b, v0.8b, v1.8b
               	str	d0, [x4]
               	ldr	d0, [sp, #0x4710]
               	ldr	d1, [sp, #0x4718]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x730
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x400
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x400
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x740
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x700
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x700
               	lsl	x3, x0, #3
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x750
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x740
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xd18
               	add	x4, x0, x0, lsl #1
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xd18
               	add	x3, x3, #0x8
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0xd18
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4e08]
               	ldr	x3, [sp, #0x4e10]
               	ldr	x4, [sp, #0x4e18]
               	str	x0, [sp, #0x4970]
               	str	x3, [sp, #0x4978]
               	str	x4, [sp, #0x4980]
               	add	x0, x1, #0x1
               	sub	x3, x29, #0xdc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x0, x29, #0xdc0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x198
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrb	w0, [x1, #0x3]
               	ldr	x16, [sp, #0x4168]
               	and	x3, x16, #0xffffffffffffff00
               	orr	x3, x3, x0
               	and	x3, x3, #0xffffffffffff00ff
               	orr	x3, x3, x0, lsl #8
               	and	x3, x3, #0xffffffffff00ffff
               	orr	x3, x3, x0, lsl #16
               	and	x3, x3, #0xffffffff00ffffff
               	orr	x3, x3, x0, lsl #24
               	and	x3, x3, #0xffffff00ffffffff
               	orr	x3, x3, x0, lsl #32
               	ldrb	w0, [x1, #0x3]
               	and	x3, x3, #0xffff00ffffffffff
               	orr	x3, x3, x0, lsl #40
               	and	x3, x3, #0xff00ffffffffffff
               	orr	x3, x3, x0, lsl #48
               	and	x3, x3, #0xffffffffffffff
               	orr	x3, x3, x0, lsl #56
               	ldrb	w0, [x1, #0x4]
               	ldr	x16, [sp, #0x4160]
               	and	x4, x16, #0xffffffffffffff00
               	orr	x4, x4, x0
               	and	x4, x4, #0xffffffffffff00ff
               	orr	x4, x4, x0, lsl #8
               	and	x4, x4, #0xffffffffff00ffff
               	orr	x4, x4, x0, lsl #16
               	and	x4, x4, #0xffffffff00ffffff
               	orr	x4, x4, x0, lsl #24
               	and	x4, x4, #0xffffff00ffffffff
               	orr	x4, x4, x0, lsl #32
               	ldrb	w0, [x1, #0x4]
               	and	x4, x4, #0xffff00ffffffffff
               	orr	x4, x4, x0, lsl #40
               	and	x4, x4, #0xff00ffffffffffff
               	orr	x4, x4, x0, lsl #48
               	and	x4, x4, #0xffffffffffffff
               	orr	x4, x4, x0, lsl #56
               	ldrb	w0, [x1, #0x5]
               	ldr	x16, [sp, #0x4158]
               	and	x5, x16, #0xffffffffffffff00
               	orr	x5, x5, x0
               	and	x5, x5, #0xffffffffffff00ff
               	orr	x5, x5, x0, lsl #8
               	and	x5, x5, #0xffffffffff00ffff
               	orr	x5, x5, x0, lsl #16
               	and	x5, x5, #0xffffffff00ffffff
               	orr	x5, x5, x0, lsl #24
               	and	x5, x5, #0xffffff00ffffffff
               	orr	x5, x5, x0, lsl #32
               	ldrb	w0, [x1, #0x5]
               	and	x5, x5, #0xffff00ffffffffff
               	orr	x5, x5, x0, lsl #40
               	and	x5, x5, #0xff00ffffffffffff
               	orr	x5, x5, x0, lsl #48
               	and	x5, x5, #0xffffffffffffff
               	orr	x0, x5, x0, lsl #56
               	str	x3, [sp, #0x49a0]
               	str	x4, [sp, #0x49a8]
               	str	x0, [sp, #0x49b0]
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x1b0
               	sub	x6, x29, #0x1, lsl #12  // =0x1000
               	sub	x6, x6, #0x150
               	str	x3, [sp, #0x4168]
               	str	x4, [sp, #0x4160]
               	str	x0, [sp, #0x4158]
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x6]
               	ldr	x16, [x5, #0x10]
               	str	x16, [x6, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x150
               	add	x1, x1, x0, lsl #3
               	ldrb	w3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x150
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x168
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x168
               	sub	x1, x29, #0xd00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0xd00
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0xd00
               	add	x3, x3, #0x8
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0xd00
               	add	x3, x3, #0x10
               	ldrb	w3, [x3, x0]
               	strb	w3, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x18
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x180
               	sub	x3, x29, #0xce8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x1, x29, #0xce8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x198
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x138
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x138
               	lsl	x2, x0, #3
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1b0
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x198
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x5120]
               	str	d5, [sp, #0x5128]
               	str	d1, [sp, #0x5130]
               	str	d0, [sp, #0x5138]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3e0
               	sub	x1, x29, #0x9e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2a0
               	lsl	x3, x0, #3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x2a0
               	add	x2, x2, x0, lsl #3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x5880]
               	ldr	x1, [sp, #0x5888]
               	ldr	x2, [sp, #0x5890]
               	ldr	x3, [sp, #0x5898]
               	str	x0, [sp, #0x5160]
               	str	x1, [sp, #0x5168]
               	str	x2, [sp, #0x5170]
               	str	x3, [sp, #0x5178]
               	sub	x0, x29, #0xa00
               	sub	x1, x29, #0x980
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x980
               	add	x1, x1, x0, lsl #3
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x980
               	sub	x1, x29, #0x9a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x9a0
               	sub	x1, x29, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5180]
               	ldr	d1, [sp, #0x5190]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldr	d1, [sp, #0x58a0]
               	ldr	d2, [sp, #0x58b0]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldr	d2, [sp, #0x58a8]
               	ldr	d3, [sp, #0x58b8]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	str	d3, [x6]
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [x6, #0x8]
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x10]
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [x6, #0x18]
               	add	x0, x6, #0x20
               	sub	x1, x29, #0x9c0
               	sub	x2, x29, #0x260
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x260
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x9e0
               	sub	x1, x29, #0x960
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x960
               	lsl	x3, x0, #3
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xa00
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x9e0
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x2920]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x2930]
               	str	q2, [sp, #0x710]
               	str	q0, [sp, #0x720]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x980
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x980
               	add	x1, sp, #0x730
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1e0
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2940]
               	ldr	q1, [sp, #0x2950]
               	str	q0, [sp, #0x750]
               	str	q1, [sp, #0x760]
               	add	x0, sp, #0x710
               	add	x1, sp, #0x770
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x770
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0x770
               	add	x1, sp, #0x790
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0x790
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x1c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x790]
               	ldr	q1, [sp, #0x7a0]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x2960]
               	ldr	q1, [sp, #0x2970]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x0, x6, #0x20
               	add	x1, sp, #0x750
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0x730
               	add	x1, sp, #0x7b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x6, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0x7b0
               	lsl	x3, x0, #4
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x710
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x730
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x180
               	add	x4, x0, x0, lsl #1
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x180
               	add	x1, x1, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x180
               	add	x1, x1, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrb	w4, [x2, w4, sxtw]
               	strb	w4, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x29a0]
               	ldr	q1, [sp, #0x29b0]
               	ldr	q2, [sp, #0x29c0]
               	str	q0, [sp, #0x7d0]
               	str	q1, [sp, #0x7e0]
               	str	q2, [sp, #0x7f0]
               	add	x0, x2, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x960
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x960
               	add	x1, sp, #0x800
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x2, #0x3
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	lsl	x5, x0, #4
               	ldrb	w6, [x1, x0]
               	strb	w6, [x4, x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x1]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x2]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x3]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x4]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x5]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x6]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x7]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x8]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0x9]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xa]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xb]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xc]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xd]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xe]
               	sub	x4, x29, #0x3, lsl #12  // =0x3000
               	sub	x4, x4, #0x150
               	add	x4, x4, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x4, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x29d0]
               	ldr	q1, [sp, #0x29e0]
               	ldr	q2, [sp, #0x29f0]
               	str	q0, [sp, #0x830]
               	str	q1, [sp, #0x840]
               	str	q2, [sp, #0x850]
               	add	x0, sp, #0x7d0
               	add	x1, sp, #0x860
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x4, x2, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x860
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x4, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, sp, #0x860
               	add	x1, sp, #0x890
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x890
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x120
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x120
               	add	x2, x2, #0x10
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x120
               	add	x2, x2, #0x20
               	ldrb	w2, [x2, x0]
               	strb	w2, [x3, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x0, x3, #0x30
               	add	x1, sp, #0x830
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xf0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0x800
               	add	x1, sp, #0x8c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x8c0
               	lsl	x2, x0, #4
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x7d0
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x800
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
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x2a60]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x2a70]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x2a80]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x2a90]
               	str	q3, [sp, #0x8f0]
               	str	q5, [sp, #0x900]
               	str	q1, [sp, #0x910]
               	str	q0, [sp, #0x920]
               	add	x0, x5, #0x1
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x930
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x930
               	add	x1, sp, #0x930
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x1]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x2]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x3]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x4]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x5]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x8]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x9]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xa]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xb]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xc]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xe]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2aa0]
               	ldr	q1, [sp, #0x2ab0]
               	ldr	q2, [sp, #0x2ac0]
               	ldr	q3, [sp, #0x2ad0]
               	str	q0, [sp, #0x970]
               	str	q1, [sp, #0x980]
               	str	q2, [sp, #0x990]
               	str	q3, [sp, #0x9a0]
               	add	x0, sp, #0x8f0
               	add	x1, sp, #0x9b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x9b0
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x0, sp, #0x9b0
               	add	x1, sp, #0x9f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x9f0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x9f0]
               	ldr	q1, [sp, #0xa10]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x2ae0]
               	ldr	q2, [sp, #0x2b00]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x2af0]
               	ldr	q3, [sp, #0x2b10]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x0, x6, #0x40
               	add	x1, sp, #0x970
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0x930
               	add	x1, sp, #0xa30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x6, #0x80
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xa30
               	lsl	x3, x0, #4
               	ldrb	w2, [x2, x3]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x8f0
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x930
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
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	str	d2, [sp, #0x4430]
               	str	d0, [sp, #0x4438]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w2, [x0, #0x4]
               	ldrh	w3, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w1, [x17, #0x920]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w2, [x17, #0x922]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w3, [x17, #0x924]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w5, [x17, #0x926]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w6, [x17, #0x928]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w7, [x17, #0x92a]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w8, [x17, #0x92c]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w9, [x17, #0x92e]
               	ldrsh	x1, [x0, #0x6]
               	ldr	x16, [sp, #0x4178]
               	and	x2, x16, #0xffffffffffff0000
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3
               	and	x2, x2, #0xffffffff0000ffff
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrsh	x1, [x0, #0x8]
               	ldr	x16, [sp, #0x4170]
               	and	x3, x16, #0xffffffffffff0000
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5
               	and	x3, x3, #0xffffffff0000ffff
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x1, x3, x1, lsl #48
               	str	x2, [sp, #0x4450]
               	str	x1, [sp, #0x4458]
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x6f0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x6b0
               	str	x2, [sp, #0x4178]
               	str	x1, [sp, #0x4170]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6b0
               	add	x2, x2, x0, lsl #3
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6c0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4460]
               	ldr	d1, [sp, #0x4468]
               	zip1	v0.4h, v0.4h, v1.4h
               	str	d0, [x4]
               	ldr	d0, [sp, #0x4730]
               	ldr	d1, [sp, #0x4738]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6e0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x6a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6a0
               	add	x2, x2, x0, lsl #3
               	ldrsh	x2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6f0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x6e0
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsh	x2, [x0]
               	ldr	x16, [sp, #0x4190]
               	and	x3, x16, #0xffffffffffff0000
               	and	x2, x2, #0xffff
               	orr	x2, x3, x2
               	ldrsh	x3, [x0, #0x2]
               	ldr	x16, [sp, #0x4188]
               	and	x4, x16, #0xffffffffffff0000
               	and	x3, x3, #0xffff
               	orr	x3, x4, x3
               	ldrsh	x4, [x0, #0x4]
               	ldr	x16, [sp, #0x4180]
               	and	x5, x16, #0xffffffffffff0000
               	and	x4, x4, #0xffff
               	orr	x4, x5, x4
               	ldrsh	x5, [x0, #0x6]
               	and	x2, x2, #0xffffffff0000ffff
               	and	x5, x5, #0xffff
               	orr	x2, x2, x5, lsl #16
               	ldrsh	x5, [x0, #0x8]
               	and	x3, x3, #0xffffffff0000ffff
               	and	x5, x5, #0xffff
               	orr	x3, x3, x5, lsl #16
               	ldrsh	x5, [x0, #0xa]
               	and	x4, x4, #0xffffffff0000ffff
               	and	x5, x5, #0xffff
               	orr	x4, x4, x5, lsl #16
               	ldrsh	x5, [x0, #0xc]
               	and	x2, x2, #0xffff0000ffffffff
               	and	x5, x5, #0xffff
               	orr	x2, x2, x5, lsl #32
               	ldrsh	x5, [x0, #0xe]
               	and	x3, x3, #0xffff0000ffffffff
               	and	x5, x5, #0xffff
               	orr	x5, x3, x5, lsl #32
               	ldrsh	x3, [x0, #0x10]
               	and	x4, x4, #0xffff0000ffffffff
               	and	x3, x3, #0xffff
               	orr	x6, x4, x3, lsl #32
               	ldrsh	x3, [x0, #0x12]
               	and	x2, x2, #0xffffffffffff
               	orr	x3, x2, x3, lsl #48
               	ldrsh	x2, [x0, #0x14]
               	and	x4, x5, #0xffffffffffff
               	orr	x4, x4, x2, lsl #48
               	ldrsh	x2, [x0, #0x16]
               	and	x5, x6, #0xffffffffffff
               	orr	x5, x5, x2, lsl #48
               	str	x3, [sp, #0x4a00]
               	str	x4, [sp, #0x4a08]
               	str	x5, [sp, #0x4a10]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w6, [x0, #0x4]
               	ldrh	w7, [x0, #0x6]
               	ldrh	w8, [x0, #0x8]
               	ldrh	w9, [x0, #0xa]
               	ldrh	w10, [x0, #0xc]
               	ldrh	w11, [x0, #0xe]
               	ldrh	w12, [x0, #0x10]
               	ldrh	w13, [x0, #0x12]
               	ldrh	w14, [x0, #0x14]
               	ldrh	w15, [x0, #0x16]
               	ldrh	w17, [x0, #0x18]
               	str	x17, [sp, #0x4190]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w2, [x17, #0xef8]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w6, [x17, #0xefa]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w7, [x17, #0xefc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w8, [x17, #0xefe]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w9, [x17, #-0x100]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w10, [x17, #-0xfe]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w11, [x17, #-0xfc]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w12, [x17, #-0xfa]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w13, [x17, #-0xf8]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w14, [x17, #-0xf6]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w15, [x17, #-0xf4]
               	ldr	x16, [sp, #0x4190]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturh	w16, [x17, #-0xf2]
               	ldrsh	x2, [x0, #0x6]
               	ldr	x16, [sp, #0x41a8]
               	and	x6, x16, #0xffffffffffff0000
               	and	x7, x2, #0xffff
               	orr	x6, x6, x7
               	and	x6, x6, #0xffffffff0000ffff
               	and	x7, x2, #0xffff
               	orr	x6, x6, x7, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	and	x7, x2, #0xffff
               	orr	x6, x6, x7, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x6, x6, x2, lsl #48
               	ldrsh	x2, [x0, #0x8]
               	ldr	x16, [sp, #0x41a0]
               	and	x7, x16, #0xffffffffffff0000
               	and	x8, x2, #0xffff
               	orr	x7, x7, x8
               	and	x7, x7, #0xffffffff0000ffff
               	and	x8, x2, #0xffff
               	orr	x7, x7, x8, lsl #16
               	and	x7, x7, #0xffff0000ffffffff
               	and	x8, x2, #0xffff
               	orr	x7, x7, x8, lsl #32
               	and	x7, x7, #0xffffffffffff
               	orr	x7, x7, x2, lsl #48
               	ldrsh	x2, [x0, #0xa]
               	ldr	x16, [sp, #0x4198]
               	and	x8, x16, #0xffffffffffff0000
               	and	x9, x2, #0xffff
               	orr	x8, x8, x9
               	and	x8, x8, #0xffffffff0000ffff
               	and	x9, x2, #0xffff
               	orr	x8, x8, x9, lsl #16
               	and	x8, x8, #0xffff0000ffffffff
               	and	x9, x2, #0xffff
               	orr	x8, x8, x9, lsl #32
               	and	x8, x8, #0xffffffffffff
               	orr	x2, x8, x2, lsl #48
               	str	x6, [sp, #0x4a30]
               	str	x7, [sp, #0x4a38]
               	str	x2, [sp, #0x4a40]
               	sub	x8, x29, #0x1, lsl #12  // =0x1000
               	sub	x8, x8, #0x120
               	sub	x9, x29, #0x1, lsl #12  // =0x1000
               	sub	x9, x9, #0xd8
               	str	x3, [sp, #0x4190]
               	str	x4, [sp, #0x4188]
               	str	x5, [sp, #0x4180]
               	str	x6, [sp, #0x41a8]
               	str	x7, [sp, #0x41a0]
               	str	x2, [sp, #0x4198]
               	ldp	x16, x17, [x8]
               	stp	x16, x17, [x9]
               	ldr	x16, [x8, #0x10]
               	str	x16, [x9, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0xd8
               	add	x3, x3, x0, lsl #3
               	ldrsh	x4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w0, [x16, #-0xd8]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w2, [x16, #-0xd6]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w3, [x16, #-0xd4]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w4, [x16, #-0xd2]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w5, [x16, #-0xd0]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w6, [x16, #-0xce]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w7, [x16, #-0xcc]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w8, [x16, #-0xca]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w9, [x16, #-0xc8]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w10, [x16, #-0xc6]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w11, [x16, #-0xc4]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w12, [x16, #-0xc2]
               	strh	w0, [x1]
               	strh	w5, [x1, #0x2]
               	strh	w9, [x1, #0x4]
               	strh	w2, [x1, #0x6]
               	strh	w6, [x1, #0x8]
               	strh	w10, [x1, #0xa]
               	strh	w3, [x1, #0xc]
               	strh	w7, [x1, #0xe]
               	strh	w11, [x1, #0x10]
               	strh	w4, [x1, #0x12]
               	strh	w8, [x1, #0x14]
               	strh	w12, [x1, #0x16]
               	add	x0, x1, #0x18
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xf0
               	sub	x3, x29, #0xcd0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x2, x29, #0xcd0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x108
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x1, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xc0
               	add	x2, x2, x0, lsl #3
               	ldrsh	x2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x120
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x108
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
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x51e0]
               	str	d5, [sp, #0x51e8]
               	str	d1, [sp, #0x51f0]
               	str	d0, [sp, #0x51f8]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x3c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3c0
               	sub	x2, x29, #0x920
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrsh	x1, [x0, #0x6]
               	ldr	x16, [sp, #0x41c8]
               	and	x2, x16, #0xffffffffffff0000
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3
               	and	x2, x2, #0xffffffff0000ffff
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	and	x3, x1, #0xffff
               	orr	x2, x2, x3, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrsh	x1, [x0, #0x8]
               	ldr	x16, [sp, #0x41c0]
               	and	x3, x16, #0xffffffffffff0000
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5
               	and	x3, x3, #0xffffffff0000ffff
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	and	x5, x1, #0xffff
               	orr	x3, x3, x5, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x3, x3, x1, lsl #48
               	ldrsh	x1, [x0, #0xa]
               	ldr	x16, [sp, #0x41b8]
               	and	x5, x16, #0xffffffffffff0000
               	and	x6, x1, #0xffff
               	orr	x5, x5, x6
               	and	x5, x5, #0xffffffff0000ffff
               	and	x6, x1, #0xffff
               	orr	x5, x5, x6, lsl #16
               	and	x5, x5, #0xffff0000ffffffff
               	and	x6, x1, #0xffff
               	orr	x5, x5, x6, lsl #32
               	and	x5, x5, #0xffffffffffff
               	orr	x5, x5, x1, lsl #48
               	ldrsh	x1, [x0, #0xc]
               	ldr	x16, [sp, #0x41b0]
               	and	x6, x16, #0xffffffffffff0000
               	and	x7, x1, #0xffff
               	orr	x6, x6, x7
               	and	x6, x6, #0xffffffff0000ffff
               	and	x7, x1, #0xffff
               	orr	x6, x6, x7, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	and	x7, x1, #0xffff
               	orr	x6, x6, x7, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x1, x6, x1, lsl #48
               	str	x2, [sp, #0x5220]
               	str	x3, [sp, #0x5228]
               	str	x5, [sp, #0x5230]
               	str	x1, [sp, #0x5238]
               	sub	x6, x29, #0x940
               	sub	x7, x29, #0x8c0
               	str	x2, [sp, #0x41c8]
               	str	x3, [sp, #0x41c0]
               	str	x5, [sp, #0x41b8]
               	str	x1, [sp, #0x41b0]
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x6, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8c0
               	add	x2, x2, x0, lsl #3
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8c0
               	sub	x1, x29, #0x8e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x8e0
               	sub	x1, x29, #0x240
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5240]
               	ldr	d1, [sp, #0x5250]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldr	d1, [sp, #0x58e0]
               	ldr	d2, [sp, #0x58f0]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldr	d2, [sp, #0x58e8]
               	ldr	d3, [sp, #0x58f8]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	str	d3, [x4]
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [x4, #0x8]
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x10]
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x900
               	sub	x2, x29, #0x220
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x220
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x920
               	sub	x1, x29, #0x8a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x8a0
               	add	x2, x2, x0, lsl #3
               	ldrsh	x2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x940
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x920
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
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2b60]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2b70]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x8f0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8f0
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x60]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x62]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x64]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x66]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x68]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x6a]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x6c]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x6e]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x70]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x72]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x74]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x76]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x78]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x7a]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x7c]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x7e]
               	ldr	q0, [sp, #0x2b80]
               	ldr	q1, [sp, #0x2b90]
               	str	q0, [sp, #0xaf0]
               	str	q1, [sp, #0xb00]
               	add	x1, sp, #0xa70
               	add	x2, sp, #0xb10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xb10
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0xb10
               	add	x1, sp, #0xb30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xb30
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xf80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xb30]
               	ldr	q1, [sp, #0xb40]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x4]
               	ldr	q0, [sp, #0x2ba0]
               	ldr	q1, [sp, #0x2bb0]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	add	x1, sp, #0xaf0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xf60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xf60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xb50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xb50
               	add	x2, x2, x0, lsl #4
               	ldrsh	x2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
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
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xf40
               	add	x4, x0, x0, lsl #1
               	ldrsh	x4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xf40
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrsh	x4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xf40
               	add	x3, x3, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrsh	x4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2be0]
               	ldr	q1, [sp, #0x2bf0]
               	ldr	q2, [sp, #0x2c00]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	add	x0, x1, #0x2
               	sub	x3, x29, #0x3, lsl #12  // =0x3000
               	sub	x3, x3, #0x8d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x8d0
               	add	x3, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xf0]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xf2]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xf4]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xf6]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xf8]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xfa]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xfc]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xfe]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x100]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x102]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x104]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x106]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x108]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x10a]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x10c]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x10e]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x110]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x112]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x114]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x116]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x118]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x11a]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x11c]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x11e]
               	ldr	q0, [sp, #0x2c10]
               	ldr	q1, [sp, #0x2c20]
               	ldr	q2, [sp, #0x2c30]
               	str	q0, [sp, #0xb70]
               	str	q1, [sp, #0xb80]
               	str	q2, [sp, #0xb90]
               	add	x0, sp, #0xa70
               	add	x3, sp, #0xba0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x4, x1, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xba0
               	add	x1, x1, x0, lsl #4
               	ldrsh	x3, [x4, x0, lsl #1]
               	strh	w3, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, sp, #0xba0
               	add	x1, sp, #0xbd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xbd0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xee0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xee0
               	ldrsh	x3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xee0
               	add	x3, x3, #0x10
               	ldrsh	x3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xee0
               	add	x3, x3, #0x20
               	ldrsh	x3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x30
               	add	x1, sp, #0xb70
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xeb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xeb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xc00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x2, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xc00
               	add	x1, x1, x0, lsl #4
               	ldrsh	x1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x4]
               	ldr	q1, [x4, #0x10]
               	ldr	q2, [x4, #0x20]
               	ldr	q3, [x4, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x2ca0]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x2cb0]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x2cc0]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x2cd0]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x0, x4, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x8a0
               	add	x1, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x4]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x8]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xc]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2ce0]
               	ldr	q1, [sp, #0x2cf0]
               	ldr	q2, [sp, #0x2d00]
               	ldr	q3, [sp, #0x2d10]
               	str	q0, [sp, #0xc30]
               	str	q1, [sp, #0xc40]
               	str	q2, [sp, #0xc50]
               	str	q3, [sp, #0xc60]
               	add	x0, sp, #0xa70
               	add	x1, sp, #0xc70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x4, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xc70
               	add	x1, x1, x0, lsl #4
               	ldrsh	x2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x0, sp, #0xc70
               	add	x1, sp, #0xcb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xcb0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xe00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0xcb0]
               	ldr	q1, [sp, #0xcd0]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x2d20]
               	ldr	q2, [sp, #0x2d40]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x2d30]
               	ldr	q3, [sp, #0x2d50]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x5]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x5, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x30]
               	add	x0, x5, #0x40
               	add	x1, sp, #0xc30
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xdc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xdc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xcf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x80
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xcf0
               	add	x2, x2, x0, lsl #4
               	ldrsh	x2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	str	d2, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w2, [x0, #0x4]
               	ldrh	w3, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	sub	x17, x29, #0x4b0
               	strh	w1, [x17]
               	sub	x17, x29, #0x4ae
               	strh	w2, [x17]
               	sub	x17, x29, #0x4ac
               	strh	w3, [x17]
               	sub	x17, x29, #0x4aa
               	strh	w5, [x17]
               	sub	x17, x29, #0x4a8
               	strh	w6, [x17]
               	sub	x17, x29, #0x4a6
               	strh	w7, [x17]
               	sub	x17, x29, #0x4a4
               	strh	w8, [x17]
               	sub	x17, x29, #0x4a2
               	strh	w9, [x17]
               	ldrh	w1, [x0, #0x6]
               	ldr	x16, [sp, #0x41d8]
               	and	x2, x16, #0xffffffffffff0000
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x1, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrh	w1, [x0, #0x8]
               	ldr	x16, [sp, #0x41d0]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x3, x3, x1, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x1, x3, x1, lsl #48
               	str	x2, [sp, #0x4490]
               	str	x1, [sp, #0x4498]
               	sub	x3, x29, #0x4d0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x670
               	str	x2, [sp, #0x41d8]
               	str	x1, [sp, #0x41d0]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x670
               	add	x2, x2, x0, lsl #3
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x670
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x680
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x680
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x44a0]
               	ldr	d1, [sp, #0x44a8]
               	zip1	v0.4h, v0.4h, v1.4h
               	str	d0, [x4]
               	ldr	d0, [sp, #0x4750]
               	ldr	d1, [sp, #0x4758]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x690
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x660
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x660
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w2, [x0]
               	ldr	x16, [sp, #0x41f0]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x2, x3, x2
               	ldrh	w3, [x0, #0x2]
               	ldr	x16, [sp, #0x41e8]
               	and	x4, x16, #0xffffffffffff0000
               	orr	x3, x4, x3
               	ldrh	w4, [x0, #0x4]
               	ldr	x16, [sp, #0x41e0]
               	and	x5, x16, #0xffffffffffff0000
               	orr	x4, x5, x4
               	ldrh	w5, [x0, #0x6]
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x5, lsl #16
               	ldrh	w5, [x0, #0x8]
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x5, lsl #16
               	ldrh	w5, [x0, #0xa]
               	and	x4, x4, #0xffffffff0000ffff
               	orr	x4, x4, x5, lsl #16
               	ldrh	w5, [x0, #0xc]
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x5, lsl #32
               	ldrh	w5, [x0, #0xe]
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x5, x3, x5, lsl #32
               	ldrh	w3, [x0, #0x10]
               	and	x4, x4, #0xffff0000ffffffff
               	orr	x6, x4, x3, lsl #32
               	ldrh	w3, [x0, #0x12]
               	and	x2, x2, #0xffffffffffff
               	orr	x3, x2, x3, lsl #48
               	ldrh	w2, [x0, #0x14]
               	and	x4, x5, #0xffffffffffff
               	orr	x4, x4, x2, lsl #48
               	ldrh	w2, [x0, #0x16]
               	and	x5, x6, #0xffffffffffff
               	orr	x5, x5, x2, lsl #48
               	str	x3, [sp, #0x5648]
               	str	x4, [sp, #0x5650]
               	str	x5, [sp, #0x5658]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w6, [x0, #0x4]
               	ldrh	w7, [x0, #0x6]
               	ldrh	w8, [x0, #0x8]
               	ldrh	w9, [x0, #0xa]
               	ldrh	w10, [x0, #0xc]
               	ldrh	w11, [x0, #0xe]
               	ldrh	w12, [x0, #0x10]
               	ldrh	w13, [x0, #0x12]
               	ldrh	w14, [x0, #0x14]
               	ldrh	w15, [x0, #0x16]
               	ldrh	w17, [x0, #0x18]
               	str	x17, [sp, #0x41f0]
               	sub	x17, x29, #0x4b8
               	strh	w2, [x17]
               	sub	x17, x29, #0x4b6
               	strh	w6, [x17]
               	sub	x17, x29, #0x4b4
               	strh	w7, [x17]
               	sub	x17, x29, #0x4b2
               	strh	w8, [x17]
               	sub	x17, x29, #0x4b0
               	strh	w9, [x17]
               	sub	x17, x29, #0x4ae
               	strh	w10, [x17]
               	sub	x17, x29, #0x4ac
               	strh	w11, [x17]
               	sub	x17, x29, #0x4aa
               	strh	w12, [x17]
               	sub	x17, x29, #0x4a8
               	strh	w13, [x17]
               	sub	x17, x29, #0x4a6
               	strh	w14, [x17]
               	sub	x17, x29, #0x4a4
               	strh	w15, [x17]
               	ldr	x16, [sp, #0x41f0]
               	sub	x17, x29, #0x4a2
               	strh	w16, [x17]
               	ldrh	w2, [x0, #0x6]
               	ldr	x16, [sp, #0x4208]
               	and	x6, x16, #0xffffffffffff0000
               	orr	x6, x6, x2
               	and	x6, x6, #0xffffffff0000ffff
               	orr	x6, x6, x2, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	orr	x6, x6, x2, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x6, x6, x2, lsl #48
               	ldrh	w2, [x0, #0x8]
               	ldr	x16, [sp, #0x4200]
               	and	x7, x16, #0xffffffffffff0000
               	orr	x7, x7, x2
               	and	x7, x7, #0xffffffff0000ffff
               	orr	x7, x7, x2, lsl #16
               	and	x7, x7, #0xffff0000ffffffff
               	orr	x7, x7, x2, lsl #32
               	and	x7, x7, #0xffffffffffff
               	orr	x7, x7, x2, lsl #48
               	ldrh	w2, [x0, #0xa]
               	ldr	x16, [sp, #0x41f8]
               	and	x8, x16, #0xffffffffffff0000
               	orr	x8, x8, x2
               	and	x8, x8, #0xffffffff0000ffff
               	orr	x8, x8, x2, lsl #16
               	and	x8, x8, #0xffff0000ffffffff
               	orr	x8, x8, x2, lsl #32
               	and	x8, x8, #0xffffffffffff
               	orr	x2, x8, x2, lsl #48
               	str	x6, [sp, #0x4a78]
               	str	x7, [sp, #0x4a80]
               	str	x2, [sp, #0x4a88]
               	sub	x8, x29, #0x4d8
               	sub	x9, x29, #0x1, lsl #12  // =0x1000
               	sub	x9, x9, #0x90
               	str	x3, [sp, #0x41f0]
               	str	x4, [sp, #0x41e8]
               	str	x5, [sp, #0x41e0]
               	str	x6, [sp, #0x4208]
               	str	x7, [sp, #0x4200]
               	str	x2, [sp, #0x41f8]
               	ldp	x16, x17, [x8]
               	stp	x16, x17, [x9]
               	ldr	x16, [x8, #0x10]
               	str	x16, [x9, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x90
               	add	x3, x3, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w0, [x16, #-0x90]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w2, [x16, #-0x8e]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w3, [x16, #-0x8c]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w4, [x16, #-0x8a]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w5, [x16, #-0x88]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w6, [x16, #-0x86]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w7, [x16, #-0x84]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w8, [x16, #-0x82]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w9, [x16, #-0x80]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w10, [x16, #-0x7e]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w11, [x16, #-0x7c]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w12, [x16, #-0x7a]
               	strh	w0, [x1]
               	strh	w5, [x1, #0x2]
               	strh	w9, [x1, #0x4]
               	strh	w2, [x1, #0x6]
               	strh	w6, [x1, #0x8]
               	strh	w10, [x1, #0xa]
               	strh	w3, [x1, #0xc]
               	strh	w7, [x1, #0xe]
               	strh	w11, [x1, #0x10]
               	strh	w4, [x1, #0x12]
               	strh	w8, [x1, #0x14]
               	strh	w12, [x1, #0x16]
               	add	x0, x1, #0x18
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xa8
               	sub	x3, x29, #0xcb8
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x2, x29, #0xcb8
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x78
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x1, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x78
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x5640]
               	str	d5, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x3a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3a0
               	sub	x2, x29, #0x4c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	ldr	x16, [sp, #0x4228]
               	and	x2, x16, #0xffffffffffff0000
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x1, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrh	w1, [x0, #0x8]
               	ldr	x16, [sp, #0x4220]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x3, x3, x1, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x3, x3, x1, lsl #48
               	ldrh	w1, [x0, #0xa]
               	ldr	x16, [sp, #0x4218]
               	and	x5, x16, #0xffffffffffff0000
               	orr	x5, x5, x1
               	and	x5, x5, #0xffffffff0000ffff
               	orr	x5, x5, x1, lsl #16
               	and	x5, x5, #0xffff0000ffffffff
               	orr	x5, x5, x1, lsl #32
               	and	x5, x5, #0xffffffffffff
               	orr	x5, x5, x1, lsl #48
               	ldrh	w1, [x0, #0xc]
               	ldr	x16, [sp, #0x4210]
               	and	x6, x16, #0xffffffffffff0000
               	orr	x6, x6, x1
               	and	x6, x6, #0xffffffff0000ffff
               	orr	x6, x6, x1, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	orr	x6, x6, x1, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x1, x6, x1, lsl #48
               	str	x2, [sp, #0x52a0]
               	str	x3, [sp, #0x52a8]
               	str	x5, [sp, #0x52b0]
               	str	x1, [sp, #0x52b8]
               	sub	x6, x29, #0x4e0
               	sub	x7, x29, #0x840
               	str	x2, [sp, #0x4228]
               	str	x3, [sp, #0x4220]
               	str	x5, [sp, #0x4218]
               	str	x1, [sp, #0x4210]
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x6, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x840
               	add	x2, x2, x0, lsl #3
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x840
               	sub	x1, x29, #0x860
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x860
               	sub	x1, x29, #0x200
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x52c0]
               	ldr	d1, [sp, #0x52d0]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldr	d1, [sp, #0x5920]
               	ldr	d2, [sp, #0x5930]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldr	d2, [sp, #0x5928]
               	ldr	d3, [sp, #0x5938]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	str	d3, [x4]
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [x4, #0x8]
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x10]
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x880
               	sub	x2, x29, #0x1e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x1e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x820
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x820
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2da0]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2db0]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x860
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x860
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2a0]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2a2]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2a4]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2a6]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2a8]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2aa]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2ac]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2ae]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2b0]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2b2]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2b4]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2b6]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2b8]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2ba]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2bc]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x2be]
               	ldr	q0, [sp, #0x2dc0]
               	ldr	q1, [sp, #0x2dd0]
               	str	q0, [sp, #0xd30]
               	str	q1, [sp, #0xd40]
               	add	x1, sp, #0xa70
               	add	x2, sp, #0xd50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xd50
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0xd50
               	add	x1, sp, #0xd70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xd70
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xd40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xd70]
               	ldr	q1, [sp, #0xd80]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x4]
               	ldr	q0, [sp, #0x2de0]
               	ldr	q1, [sp, #0x2df0]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	add	x1, sp, #0xd30
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xd20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xd20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xd90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xd90
               	add	x2, x2, x0, lsl #4
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xd00
               	add	x4, x0, x0, lsl #1
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xd00
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xd00
               	add	x3, x3, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2e20]
               	ldr	q1, [sp, #0x2e30]
               	ldr	q2, [sp, #0x2e40]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	add	x0, x1, #0x2
               	sub	x3, x29, #0x3, lsl #12  // =0x3000
               	sub	x3, x3, #0x840
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x840
               	add	x3, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x330]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x332]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x334]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x336]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x338]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x33a]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x33c]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x33e]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x340]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x342]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x344]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x346]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x348]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x34a]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x34c]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x34e]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x350]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x352]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x354]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x356]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x358]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x35a]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x35c]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x35e]
               	ldr	q0, [sp, #0x2e50]
               	ldr	q1, [sp, #0x2e60]
               	ldr	q2, [sp, #0x2e70]
               	str	q0, [sp, #0xdb0]
               	str	q1, [sp, #0xdc0]
               	str	q2, [sp, #0xdd0]
               	add	x0, sp, #0xa70
               	add	x3, sp, #0xde0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x4, x1, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xde0
               	add	x1, x1, x0, lsl #4
               	ldrh	w3, [x4, x0, lsl #1]
               	strh	w3, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, sp, #0xde0
               	add	x1, sp, #0xe10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xe10
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xca0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xca0
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xca0
               	add	x3, x3, #0x10
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xca0
               	add	x3, x3, #0x20
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x30
               	add	x1, sp, #0xdb0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xc70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xc70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xe40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x2, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xe40
               	add	x1, x1, x0, lsl #4
               	ldrh	w1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x4]
               	ldr	q1, [x4, #0x10]
               	ldr	q2, [x4, #0x20]
               	ldr	q3, [x4, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x2ee0]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x2ef0]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x2f00]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x2f10]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x0, x4, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x810
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x810
               	add	x1, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x4]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x8]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xc]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2f20]
               	ldr	q1, [sp, #0x2f30]
               	ldr	q2, [sp, #0x2f40]
               	ldr	q3, [sp, #0x2f50]
               	str	q0, [sp, #0xe70]
               	str	q1, [sp, #0xe80]
               	str	q2, [sp, #0xe90]
               	str	q3, [sp, #0xea0]
               	add	x0, sp, #0xa70
               	add	x1, sp, #0xeb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x4, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xeb0
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x0, sp, #0xeb0
               	add	x1, sp, #0xef0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xef0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xbc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0xef0]
               	ldr	q1, [sp, #0xf10]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x2f60]
               	ldr	q2, [sp, #0x2f80]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x2f70]
               	ldr	q3, [sp, #0x2f90]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x5]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x5, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x30]
               	add	x0, x5, #0x40
               	add	x1, sp, #0xe70
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xb80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xb80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xf30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x80
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xf30
               	add	x2, x2, x0, lsl #4
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	str	d2, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w2, [x0, #0x4]
               	ldrh	w3, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	sub	x17, x29, #0x4b0
               	strh	w1, [x17]
               	sub	x17, x29, #0x4ae
               	strh	w2, [x17]
               	sub	x17, x29, #0x4ac
               	strh	w3, [x17]
               	sub	x17, x29, #0x4aa
               	strh	w5, [x17]
               	sub	x17, x29, #0x4a8
               	strh	w6, [x17]
               	sub	x17, x29, #0x4a6
               	strh	w7, [x17]
               	sub	x17, x29, #0x4a4
               	strh	w8, [x17]
               	sub	x17, x29, #0x4a2
               	strh	w9, [x17]
               	ldrh	w1, [x0, #0x6]
               	ldr	x16, [sp, #0x4238]
               	and	x2, x16, #0xffffffffffff0000
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x1, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrh	w1, [x0, #0x8]
               	ldr	x16, [sp, #0x4230]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x3, x3, x1, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x1, x3, x1, lsl #48
               	str	x2, [sp, #0x44d0]
               	str	x1, [sp, #0x44d8]
               	sub	x3, x29, #0x4d0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x630
               	str	x2, [sp, #0x4238]
               	str	x1, [sp, #0x4230]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x630
               	add	x2, x2, x0, lsl #3
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x630
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x640
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x640
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x44e0]
               	ldr	d1, [sp, #0x44e8]
               	zip1	v0.4h, v0.4h, v1.4h
               	str	d0, [x4]
               	ldr	d0, [sp, #0x4770]
               	ldr	d1, [sp, #0x4778]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x650
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x620
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x620
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w2, [x0]
               	ldr	x16, [sp, #0x4250]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x2, x3, x2
               	ldrh	w3, [x0, #0x2]
               	ldr	x16, [sp, #0x4248]
               	and	x4, x16, #0xffffffffffff0000
               	orr	x3, x4, x3
               	ldrh	w4, [x0, #0x4]
               	ldr	x16, [sp, #0x4240]
               	and	x5, x16, #0xffffffffffff0000
               	orr	x4, x5, x4
               	ldrh	w5, [x0, #0x6]
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x5, lsl #16
               	ldrh	w5, [x0, #0x8]
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x5, lsl #16
               	ldrh	w5, [x0, #0xa]
               	and	x4, x4, #0xffffffff0000ffff
               	orr	x4, x4, x5, lsl #16
               	ldrh	w5, [x0, #0xc]
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x5, lsl #32
               	ldrh	w5, [x0, #0xe]
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x5, x3, x5, lsl #32
               	ldrh	w3, [x0, #0x10]
               	and	x4, x4, #0xffff0000ffffffff
               	orr	x6, x4, x3, lsl #32
               	ldrh	w3, [x0, #0x12]
               	and	x2, x2, #0xffffffffffff
               	orr	x3, x2, x3, lsl #48
               	ldrh	w2, [x0, #0x14]
               	and	x4, x5, #0xffffffffffff
               	orr	x4, x4, x2, lsl #48
               	ldrh	w2, [x0, #0x16]
               	and	x5, x6, #0xffffffffffff
               	orr	x5, x5, x2, lsl #48
               	str	x3, [sp, #0x5648]
               	str	x4, [sp, #0x5650]
               	str	x5, [sp, #0x5658]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w6, [x0, #0x4]
               	ldrh	w7, [x0, #0x6]
               	ldrh	w8, [x0, #0x8]
               	ldrh	w9, [x0, #0xa]
               	ldrh	w10, [x0, #0xc]
               	ldrh	w11, [x0, #0xe]
               	ldrh	w12, [x0, #0x10]
               	ldrh	w13, [x0, #0x12]
               	ldrh	w14, [x0, #0x14]
               	ldrh	w15, [x0, #0x16]
               	ldrh	w17, [x0, #0x18]
               	str	x17, [sp, #0x4250]
               	sub	x17, x29, #0x4b8
               	strh	w2, [x17]
               	sub	x17, x29, #0x4b6
               	strh	w6, [x17]
               	sub	x17, x29, #0x4b4
               	strh	w7, [x17]
               	sub	x17, x29, #0x4b2
               	strh	w8, [x17]
               	sub	x17, x29, #0x4b0
               	strh	w9, [x17]
               	sub	x17, x29, #0x4ae
               	strh	w10, [x17]
               	sub	x17, x29, #0x4ac
               	strh	w11, [x17]
               	sub	x17, x29, #0x4aa
               	strh	w12, [x17]
               	sub	x17, x29, #0x4a8
               	strh	w13, [x17]
               	sub	x17, x29, #0x4a6
               	strh	w14, [x17]
               	sub	x17, x29, #0x4a4
               	strh	w15, [x17]
               	ldr	x16, [sp, #0x4250]
               	sub	x17, x29, #0x4a2
               	strh	w16, [x17]
               	ldrh	w2, [x0, #0x6]
               	ldr	x16, [sp, #0x4268]
               	and	x6, x16, #0xffffffffffff0000
               	orr	x6, x6, x2
               	and	x6, x6, #0xffffffff0000ffff
               	orr	x6, x6, x2, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	orr	x6, x6, x2, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x6, x6, x2, lsl #48
               	ldrh	w2, [x0, #0x8]
               	ldr	x16, [sp, #0x4260]
               	and	x7, x16, #0xffffffffffff0000
               	orr	x7, x7, x2
               	and	x7, x7, #0xffffffff0000ffff
               	orr	x7, x7, x2, lsl #16
               	and	x7, x7, #0xffff0000ffffffff
               	orr	x7, x7, x2, lsl #32
               	and	x7, x7, #0xffffffffffff
               	orr	x7, x7, x2, lsl #48
               	ldrh	w2, [x0, #0xa]
               	ldr	x16, [sp, #0x4258]
               	and	x8, x16, #0xffffffffffff0000
               	orr	x8, x8, x2
               	and	x8, x8, #0xffffffff0000ffff
               	orr	x8, x8, x2, lsl #16
               	and	x8, x8, #0xffff0000ffffffff
               	orr	x8, x8, x2, lsl #32
               	and	x8, x8, #0xffffffffffff
               	orr	x2, x8, x2, lsl #48
               	str	x6, [sp, #0x4ac0]
               	str	x7, [sp, #0x4ac8]
               	str	x2, [sp, #0x4ad0]
               	sub	x8, x29, #0x4d8
               	sub	x9, x29, #0x1, lsl #12  // =0x1000
               	sub	x9, x9, #0x48
               	str	x3, [sp, #0x4250]
               	str	x4, [sp, #0x4248]
               	str	x5, [sp, #0x4240]
               	str	x6, [sp, #0x4268]
               	str	x7, [sp, #0x4260]
               	str	x2, [sp, #0x4258]
               	ldp	x16, x17, [x8]
               	stp	x16, x17, [x9]
               	ldr	x16, [x8, #0x10]
               	str	x16, [x9, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x1, lsl #12  // =0x1000
               	sub	x3, x3, #0x48
               	add	x3, x3, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w0, [x16, #-0x48]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w2, [x16, #-0x46]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w3, [x16, #-0x44]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w4, [x16, #-0x42]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w5, [x16, #-0x40]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w6, [x16, #-0x3e]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w7, [x16, #-0x3c]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w8, [x16, #-0x3a]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w9, [x16, #-0x38]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w10, [x16, #-0x36]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w11, [x16, #-0x34]
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldurh	w12, [x16, #-0x32]
               	strh	w0, [x1]
               	strh	w5, [x1, #0x2]
               	strh	w9, [x1, #0x4]
               	strh	w2, [x1, #0x6]
               	strh	w6, [x1, #0x8]
               	strh	w10, [x1, #0xa]
               	strh	w3, [x1, #0xc]
               	strh	w7, [x1, #0xe]
               	strh	w11, [x1, #0x10]
               	strh	w4, [x1, #0x12]
               	strh	w8, [x1, #0x14]
               	strh	w12, [x1, #0x16]
               	add	x0, x1, #0x18
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x60
               	sub	x3, x29, #0xca0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x3, #0x10]
               	sub	x2, x29, #0xca0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x1, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x30
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x5640]
               	str	d5, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x380
               	sub	x2, x29, #0x4c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	ldr	x16, [sp, #0x4288]
               	and	x2, x16, #0xffffffffffff0000
               	orr	x2, x2, x1
               	and	x2, x2, #0xffffffff0000ffff
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0xffff0000ffffffff
               	orr	x2, x2, x1, lsl #32
               	and	x2, x2, #0xffffffffffff
               	orr	x2, x2, x1, lsl #48
               	ldrh	w1, [x0, #0x8]
               	ldr	x16, [sp, #0x4280]
               	and	x3, x16, #0xffffffffffff0000
               	orr	x3, x3, x1
               	and	x3, x3, #0xffffffff0000ffff
               	orr	x3, x3, x1, lsl #16
               	and	x3, x3, #0xffff0000ffffffff
               	orr	x3, x3, x1, lsl #32
               	and	x3, x3, #0xffffffffffff
               	orr	x3, x3, x1, lsl #48
               	ldrh	w1, [x0, #0xa]
               	ldr	x16, [sp, #0x4278]
               	and	x5, x16, #0xffffffffffff0000
               	orr	x5, x5, x1
               	and	x5, x5, #0xffffffff0000ffff
               	orr	x5, x5, x1, lsl #16
               	and	x5, x5, #0xffff0000ffffffff
               	orr	x5, x5, x1, lsl #32
               	and	x5, x5, #0xffffffffffff
               	orr	x5, x5, x1, lsl #48
               	ldrh	w1, [x0, #0xc]
               	ldr	x16, [sp, #0x4270]
               	and	x6, x16, #0xffffffffffff0000
               	orr	x6, x6, x1
               	and	x6, x6, #0xffffffff0000ffff
               	orr	x6, x6, x1, lsl #16
               	and	x6, x6, #0xffff0000ffffffff
               	orr	x6, x6, x1, lsl #32
               	and	x6, x6, #0xffffffffffff
               	orr	x1, x6, x1, lsl #48
               	str	x2, [sp, #0x5320]
               	str	x3, [sp, #0x5328]
               	str	x5, [sp, #0x5330]
               	str	x1, [sp, #0x5338]
               	sub	x6, x29, #0x4e0
               	sub	x7, x29, #0x7c0
               	str	x2, [sp, #0x4288]
               	str	x3, [sp, #0x4280]
               	str	x5, [sp, #0x4278]
               	str	x1, [sp, #0x4270]
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x6, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x7c0
               	add	x2, x2, x0, lsl #3
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x7c0
               	sub	x1, x29, #0x7e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x7e0
               	sub	x1, x29, #0x1c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5340]
               	ldr	d1, [sp, #0x5350]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldr	d1, [sp, #0x5960]
               	ldr	d2, [sp, #0x5970]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldr	d2, [sp, #0x5968]
               	ldr	d3, [sp, #0x5978]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	str	d3, [x4]
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [x4, #0x8]
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x10]
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x800
               	sub	x2, x29, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x7a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x7a0
               	add	x2, x2, x0, lsl #3
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2fe0]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2ff0]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x7d0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7d0
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4e0]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4e2]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4e4]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4e6]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4e8]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4ea]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4ec]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4ee]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4f0]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4f2]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4f4]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4f6]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4f8]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4fa]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4fc]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x4fe]
               	ldr	q0, [sp, #0x3000]
               	ldr	q1, [sp, #0x3010]
               	str	q0, [sp, #0xf70]
               	str	q1, [sp, #0xf80]
               	add	x1, sp, #0xa70
               	add	x2, sp, #0xf90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xf90
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x0, sp, #0xf90
               	add	x1, sp, #0xfb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xfb0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xb00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xfb0]
               	ldr	q1, [sp, #0xfc0]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x4]
               	ldr	q0, [sp, #0x3020]
               	ldr	q1, [sp, #0x3030]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	add	x1, sp, #0xf70
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xae0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xae0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	add	x1, sp, #0xfd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	add	x2, sp, #0xfd0
               	add	x2, x2, x0, lsl #4
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xac0
               	add	x4, x0, x0, lsl #1
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xac0
               	add	x3, x3, #0x10
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x1
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xac0
               	add	x3, x3, #0x20
               	add	x4, x0, x0, lsl #1
               	add	x4, x4, #0x2
               	ldrh	w4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x3060]
               	ldr	q1, [sp, #0x3070]
               	ldr	q2, [sp, #0x3080]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	add	x0, x1, #0x2
               	sub	x3, x29, #0x3, lsl #12  // =0x3000
               	sub	x3, x3, #0x7b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x7b0
               	add	x3, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x570]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x572]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x574]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x576]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x578]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x57a]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x57c]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x57e]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x580]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x582]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x584]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x586]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x588]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x58a]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x58c]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x58e]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x590]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x592]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x594]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x596]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x598]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x59a]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x59c]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x59e]
               	ldr	q0, [sp, #0x3090]
               	ldr	q1, [sp, #0x30a0]
               	ldr	q2, [sp, #0x30b0]
               	str	q0, [sp, #0xff0]
               	str	q1, [sp, #0x1000]
               	str	q2, [sp, #0x1010]
               	add	x0, sp, #0xa70
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xb00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x4, x1, #0xa
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xb00
               	add	x1, x1, x0, lsl #4
               	ldrh	w3, [x4, x0, lsl #1]
               	strh	w3, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xb00
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xad0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xad0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xa60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xa60
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xa60
               	add	x3, x3, #0x10
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x2
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xa60
               	add	x3, x3, #0x20
               	ldrh	w3, [x3, x0, lsl #1]
               	strh	w3, [x2, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x0, x2, #0x30
               	add	x1, sp, #0xff0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0xa30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xa30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xaa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x2, #0x60
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xaa0
               	add	x1, x1, x0, lsl #4
               	ldrh	w1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x4]
               	ldr	q1, [x4, #0x10]
               	ldr	q2, [x4, #0x20]
               	ldr	q3, [x4, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x3120]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x3130]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x3140]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x3150]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x0, x4, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x780
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x780
               	add	x1, sp, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x2]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x4]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0x8]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xc]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x9c0
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x3160]
               	ldr	q1, [sp, #0x3170]
               	ldr	q2, [sp, #0x3180]
               	ldr	q3, [sp, #0x3190]
               	str	q0, [sp, #0x10b0]
               	str	q1, [sp, #0x10c0]
               	str	q2, [sp, #0x10d0]
               	str	q3, [sp, #0x10e0]
               	add	x0, sp, #0xa70
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x4, #0xa
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa30
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xa30
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x9f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x9f0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x980
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1130]
               	ldr	q1, [sp, #0x1150]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x31a0]
               	ldr	q2, [sp, #0x31c0]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x31b0]
               	ldr	q3, [sp, #0x31d0]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x5]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x5, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x5, #0x30]
               	add	x0, x5, #0x40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa70
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x940
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x940
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x9b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x9b0
               	add	x2, x2, x0, lsl #4
               	ldrh	w2, [x2]
               	strh	w2, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	str	d2, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x4b0
               	str	w1, [x17]
               	sub	x17, x29, #0x4ac
               	str	w2, [x17]
               	sub	x17, x29, #0x4a8
               	str	w3, [x17]
               	sub	x17, x29, #0x4a4
               	str	w5, [x17]
               	ldrsw	x1, [x0, #0xc]
               	ldr	x16, [sp, #0x4298]
               	and	x2, x16, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x1, x2, x1, lsl #32
               	ldrsw	x2, [x0, #0x10]
               	ldr	x16, [sp, #0x4290]
               	and	x3, x16, #0xffffffff00000000
               	orr	x3, x3, x2
               	mov	w3, w3
               	orr	x2, x3, x2, lsl #32
               	str	x1, [sp, #0x4510]
               	str	x2, [sp, #0x4518]
               	sub	x3, x29, #0x4d0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x5f0
               	str	x1, [sp, #0x4298]
               	str	x2, [sp, #0x4290]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5f0
               	add	x2, x2, x0, lsl #3
               	ldrsw	x3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x600
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x600
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x390
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4520]
               	ldr	d1, [sp, #0x4528]
               	zip1	v0.2s, v0.2s, v1.2s
               	str	d0, [x4]
               	ldr	d0, [sp, #0x4790]
               	ldr	d1, [sp, #0x4798]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x610
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5e0
               	add	x2, x2, x0, lsl #3
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x1, [x0]
               	ldr	x16, [sp, #0x42b0]
               	and	x2, x16, #0xffffffff00000000
               	orr	x1, x2, x1
               	ldrsw	x2, [x0, #0x4]
               	ldr	x16, [sp, #0x42a8]
               	and	x3, x16, #0xffffffff00000000
               	orr	x2, x3, x2
               	ldrsw	x3, [x0, #0x8]
               	ldr	x16, [sp, #0x42a0]
               	and	x5, x16, #0xffffffff00000000
               	orr	x3, x5, x3
               	ldrsw	x5, [x0, #0xc]
               	mov	w1, w1
               	orr	x1, x1, x5, lsl #32
               	ldrsw	x5, [x0, #0x10]
               	mov	w2, w2
               	orr	x2, x2, x5, lsl #32
               	ldrsw	x5, [x0, #0x14]
               	mov	w3, w3
               	orr	x3, x3, x5, lsl #32
               	str	x1, [sp, #0x5648]
               	str	x2, [sp, #0x5650]
               	str	x3, [sp, #0x5658]
               	ldr	w5, [x0, #0x4]
               	ldr	w6, [x0, #0x8]
               	ldr	w7, [x0, #0xc]
               	ldr	w8, [x0, #0x10]
               	ldr	w9, [x0, #0x14]
               	ldr	w10, [x0, #0x18]
               	sub	x17, x29, #0x4b8
               	str	w5, [x17]
               	sub	x17, x29, #0x4b4
               	str	w6, [x17]
               	sub	x17, x29, #0x4b0
               	str	w7, [x17]
               	sub	x17, x29, #0x4ac
               	str	w8, [x17]
               	sub	x17, x29, #0x4a8
               	str	w9, [x17]
               	sub	x17, x29, #0x4a4
               	str	w10, [x17]
               	ldrsw	x5, [x0, #0xc]
               	ldr	x16, [sp, #0x42c8]
               	and	x6, x16, #0xffffffff00000000
               	orr	x6, x6, x5
               	mov	w6, w6
               	orr	x5, x6, x5, lsl #32
               	ldrsw	x6, [x0, #0x10]
               	ldr	x16, [sp, #0x42c0]
               	and	x7, x16, #0xffffffff00000000
               	orr	x7, x7, x6
               	mov	w7, w7
               	orr	x6, x7, x6, lsl #32
               	ldrsw	x7, [x0, #0x14]
               	ldr	x16, [sp, #0x42b8]
               	and	x8, x16, #0xffffffff00000000
               	orr	x8, x8, x7
               	mov	w8, w8
               	orr	x7, x8, x7, lsl #32
               	str	x5, [sp, #0x4b08]
               	str	x6, [sp, #0x4b10]
               	str	x7, [sp, #0x4b18]
               	sub	x8, x29, #0x4d8
               	sub	x9, x29, #0x1, lsl #12  // =0x1000
               	str	x1, [sp, #0x42b0]
               	str	x2, [sp, #0x42a8]
               	str	x3, [sp, #0x42a0]
               	str	x5, [sp, #0x42c8]
               	str	x6, [sp, #0x42c0]
               	str	x7, [sp, #0x42b8]
               	ldp	x16, x17, [x8]
               	stp	x16, x17, [x9]
               	ldr	x16, [x8, #0x10]
               	str	x16, [x9, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	add	x2, x2, x0, lsl #3
               	ldrsw	x3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x16, x29, #0x1, lsl #12 // =0x1000
               	ldr	w0, [x16]
               	sub	x16, x29, #0xffc
               	ldr	w1, [x16]
               	sub	x16, x29, #0xff8
               	ldr	w2, [x16]
               	sub	x16, x29, #0xff4
               	ldr	w3, [x16]
               	sub	x16, x29, #0xff0
               	ldr	w5, [x16]
               	sub	x16, x29, #0xfec
               	ldr	w6, [x16]
               	str	w0, [x4]
               	str	w2, [x4, #0x4]
               	str	w5, [x4, #0x8]
               	str	w1, [x4, #0xc]
               	str	w3, [x4, #0x10]
               	str	w6, [x4, #0x14]
               	add	x0, x4, #0x18
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x18
               	sub	x2, x29, #0xc88
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xc88
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xfe8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x4, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xfe8
               	add	x2, x2, x0, lsl #3
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	str	d3, [sp, #0x5640]
               	str	d5, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x4c0
               	str	w1, [x17]
               	sub	x17, x29, #0x4bc
               	str	w2, [x17]
               	sub	x17, x29, #0x4b8
               	str	w3, [x17]
               	sub	x17, x29, #0x4b4
               	str	w5, [x17]
               	sub	x17, x29, #0x4b0
               	str	w6, [x17]
               	sub	x17, x29, #0x4ac
               	str	w7, [x17]
               	sub	x17, x29, #0x4a8
               	str	w8, [x17]
               	sub	x17, x29, #0x4a4
               	str	w9, [x17]
               	ldrsw	x1, [x0, #0xc]
               	ldr	x16, [sp, #0x42e8]
               	and	x2, x16, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x1, x2, x1, lsl #32
               	ldrsw	x2, [x0, #0x10]
               	ldr	x16, [sp, #0x42e0]
               	and	x3, x16, #0xffffffff00000000
               	orr	x3, x3, x2
               	mov	w3, w3
               	orr	x2, x3, x2, lsl #32
               	ldrsw	x3, [x0, #0x14]
               	ldr	x16, [sp, #0x42d8]
               	and	x5, x16, #0xffffffff00000000
               	orr	x5, x5, x3
               	mov	w5, w5
               	orr	x3, x5, x3, lsl #32
               	ldrsw	x5, [x0, #0x18]
               	ldr	x16, [sp, #0x42d0]
               	and	x6, x16, #0xffffffff00000000
               	orr	x6, x6, x5
               	mov	w6, w6
               	orr	x5, x6, x5, lsl #32
               	str	x1, [sp, #0x53a0]
               	str	x2, [sp, #0x53a8]
               	str	x3, [sp, #0x53b0]
               	str	x5, [sp, #0x53b8]
               	sub	x6, x29, #0x4e0
               	sub	x7, x29, #0x740
               	str	x1, [sp, #0x42e8]
               	str	x2, [sp, #0x42e0]
               	str	x3, [sp, #0x42d8]
               	str	x5, [sp, #0x42d0]
               	ldp	x16, x17, [x6]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x6, #0x10]
               	stp	x16, x17, [x7, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x740
               	add	x2, x2, x0, lsl #3
               	ldrsw	x3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x740
               	sub	x1, x29, #0x760
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x760
               	sub	x1, x29, #0x180
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x53c0]
               	ldr	d1, [sp, #0x53d0]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldr	d1, [sp, #0x59a0]
               	ldr	d2, [sp, #0x59b0]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldr	d2, [sp, #0x59a8]
               	ldr	d3, [sp, #0x59b8]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	str	d3, [x4]
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [x4, #0x8]
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [x4, #0x10]
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x780
               	sub	x2, x29, #0x160
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x160
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x720
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x720
               	add	x2, x2, x0, lsl #3
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x3220]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3230]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xab0]
               	str	w2, [sp, #0xab4]
               	str	w3, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3240]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3244]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3248]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x324c]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3250]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3254]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3258]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x325c]
               	ldr	q0, [sp, #0x3240]
               	ldr	q1, [sp, #0x3250]
               	str	q0, [sp, #0x11b0]
               	str	q1, [sp, #0x11c0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x950
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x950
               	add	x2, x2, x0, lsl #4
               	ldrsw	x3, [x1, x0, lsl #2]
               	str	w3, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x950
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x930
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x930
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x8c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x11f0]
               	ldr	q1, [sp, #0x1200]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x4]
               	ldr	q0, [sp, #0x3260]
               	ldr	q1, [sp, #0x3270]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x970
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x8a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x8a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x910
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x910
               	add	x2, x2, x0, lsl #4
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x0]
               	str	w2, [sp, #0x32a0]
               	ldrsw	x2, [x0, #0x4]
               	str	w2, [sp, #0x32b0]
               	ldrsw	x2, [x0, #0x8]
               	str	w2, [sp, #0x32c0]
               	ldrsw	x2, [x0, #0xc]
               	str	w2, [sp, #0x32a4]
               	ldrsw	x2, [x0, #0x10]
               	str	w2, [sp, #0x32b4]
               	ldrsw	x2, [x0, #0x14]
               	str	w2, [sp, #0x32c4]
               	ldrsw	x2, [x0, #0x18]
               	str	w2, [sp, #0x32a8]
               	ldrsw	x2, [x0, #0x1c]
               	str	w2, [sp, #0x32b8]
               	ldrsw	x2, [x0, #0x20]
               	str	w2, [sp, #0x32c8]
               	ldrsw	x2, [x0, #0x24]
               	str	w2, [sp, #0x32ac]
               	ldrsw	x2, [x0, #0x28]
               	str	w2, [sp, #0x32bc]
               	ldrsw	x2, [x0, #0x2c]
               	str	w2, [sp, #0x32cc]
               	ldr	q0, [sp, #0x32a0]
               	ldr	q1, [sp, #0x32b0]
               	ldr	q2, [sp, #0x32c0]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w2, [sp, #0xab0]
               	str	w3, [sp, #0xab4]
               	str	w4, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	str	w10, [sp, #0xad0]
               	str	w11, [sp, #0xad4]
               	str	w12, [sp, #0xad8]
               	str	w13, [sp, #0xadc]
               	ldrsw	x2, [x0, #0xc]
               	str	w2, [sp, #0x32d0]
               	ldrsw	x2, [x0, #0xc]
               	str	w2, [sp, #0x32d4]
               	ldrsw	x2, [x0, #0xc]
               	str	w2, [sp, #0x32d8]
               	ldrsw	x2, [x0, #0xc]
               	str	w2, [sp, #0x32dc]
               	ldrsw	x2, [x0, #0x10]
               	str	w2, [sp, #0x32e0]
               	ldrsw	x2, [x0, #0x10]
               	str	w2, [sp, #0x32e4]
               	ldrsw	x2, [x0, #0x10]
               	str	w2, [sp, #0x32e8]
               	ldrsw	x2, [x0, #0x10]
               	str	w2, [sp, #0x32ec]
               	ldrsw	x2, [x0, #0x14]
               	str	w2, [sp, #0x32f0]
               	ldrsw	x2, [x0, #0x14]
               	str	w2, [sp, #0x32f4]
               	ldrsw	x2, [x0, #0x14]
               	str	w2, [sp, #0x32f8]
               	ldrsw	x2, [x0, #0x14]
               	str	w2, [sp, #0x32fc]
               	ldr	q0, [sp, #0x32d0]
               	ldr	q1, [sp, #0x32e0]
               	ldr	q2, [sp, #0x32f0]
               	str	q0, [sp, #0x1230]
               	str	q1, [sp, #0x1240]
               	str	q2, [sp, #0x1250]
               	add	x2, sp, #0xa70
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x8c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x8c0
               	add	x3, x3, x0, lsl #4
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	w0, [sp, #0x1260]
               	ldr	w2, [sp, #0x1264]
               	ldr	w3, [sp, #0x1268]
               	ldr	w4, [sp, #0x126c]
               	ldr	w5, [sp, #0x1270]
               	ldr	w6, [sp, #0x1274]
               	ldr	w7, [sp, #0x1278]
               	ldr	w8, [sp, #0x127c]
               	ldr	w9, [sp, #0x1280]
               	ldr	w10, [sp, #0x1284]
               	ldr	w11, [sp, #0x1288]
               	ldr	w12, [sp, #0x128c]
               	str	w0, [x1]
               	str	w5, [x1, #0x4]
               	str	w9, [x1, #0x8]
               	str	w2, [x1, #0xc]
               	str	w6, [x1, #0x10]
               	str	w10, [x1, #0x14]
               	str	w3, [x1, #0x18]
               	str	w7, [x1, #0x1c]
               	str	w11, [x1, #0x20]
               	str	w4, [x1, #0x24]
               	str	w8, [x1, #0x28]
               	str	w12, [x1, #0x2c]
               	add	x0, x1, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x8f0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x820
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x820
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x890
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x1, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x890
               	add	x2, x2, x0, lsl #4
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3330]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3340]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x3350]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x3360]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x1, x0, #0x4
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x740
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x740
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3370]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3374]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3378]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x337c]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3380]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3384]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3388]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x338c]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3390]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3394]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3398]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x339c]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x33a0]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x33a4]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x33a8]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x33ac]
               	ldr	q0, [sp, #0x3370]
               	ldr	q1, [sp, #0x3380]
               	ldr	q2, [sp, #0x3390]
               	ldr	q3, [sp, #0x33a0]
               	str	q0, [sp, #0x12c0]
               	str	q1, [sp, #0x12d0]
               	str	q2, [sp, #0x12e0]
               	str	q3, [sp, #0x12f0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x820
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x820
               	add	x2, x2, x0, lsl #4
               	ldrsw	x3, [x1, x0, lsl #2]
               	str	w3, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x820
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x7e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x7e0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x770
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1340]
               	ldr	q1, [sp, #0x1360]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x33b0]
               	ldr	q2, [sp, #0x33d0]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x33c0]
               	ldr	q3, [sp, #0x33e0]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x4]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x4, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x4, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x4, #0x30]
               	add	x0, x4, #0x40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x860
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x730
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x730
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x7a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x7a0
               	add	x2, x2, x0, lsl #4
               	ldrsw	x2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	str	d2, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x4b0
               	str	w1, [x17]
               	sub	x17, x29, #0x4ac
               	str	w2, [x17]
               	sub	x17, x29, #0x4a8
               	str	w3, [x17]
               	sub	x17, x29, #0x4a4
               	str	w5, [x17]
               	ldr	w1, [x0, #0xc]
               	ldr	x16, [sp, #0x42f8]
               	and	x2, x16, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x1, x2, x1, lsl #32
               	ldr	w2, [x0, #0x10]
               	ldr	x16, [sp, #0x42f0]
               	and	x3, x16, #0xffffffff00000000
               	orr	x3, x3, x2
               	mov	w3, w3
               	orr	x2, x3, x2, lsl #32
               	str	x1, [sp, #0x4550]
               	str	x2, [sp, #0x4558]
               	sub	x3, x29, #0x4d0
               	sub	x5, x29, #0x1, lsl #12  // =0x1000
               	sub	x5, x5, #0x5b0
               	str	x1, [sp, #0x42f8]
               	str	x2, [sp, #0x42f0]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5b0
               	add	x2, x2, x0, lsl #3
               	ldr	w3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x5c0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x370
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4560]
               	ldr	d1, [sp, #0x4568]
               	zip1	v0.2s, v0.2s, v1.2s
               	str	d0, [x4]
               	ldr	d0, [sp, #0x47b0]
               	ldr	d1, [sp, #0x47b8]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x360
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x360
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x5a0
               	add	x2, x2, x0, lsl #3
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	w1, [x0]
               	and	x2, x28, #0xffffffff00000000
               	orr	x1, x2, x1
               	ldr	w2, [x0, #0x4]
               	ldr	x16, [sp, #0x4308]
               	and	x3, x16, #0xffffffff00000000
               	orr	x2, x3, x2
               	ldr	w3, [x0, #0x8]
               	ldr	x16, [sp, #0x4300]
               	and	x5, x16, #0xffffffff00000000
               	orr	x3, x5, x3
               	ldr	w5, [x0, #0xc]
               	mov	w1, w1
               	orr	x28, x1, x5, lsl #32
               	ldr	w1, [x0, #0x10]
               	mov	w2, w2
               	orr	x1, x2, x1, lsl #32
               	ldr	w2, [x0, #0x14]
               	mov	w3, w3
               	orr	x2, x3, x2, lsl #32
               	str	x28, [sp, #0x5648]
               	str	x1, [sp, #0x5650]
               	str	x2, [sp, #0x5658]
               	ldr	w3, [x0, #0x4]
               	ldr	w5, [x0, #0x8]
               	ldr	w6, [x0, #0xc]
               	ldr	w7, [x0, #0x10]
               	ldr	w8, [x0, #0x14]
               	ldr	w9, [x0, #0x18]
               	sub	x17, x29, #0x4b8
               	str	w3, [x17]
               	sub	x17, x29, #0x4b4
               	str	w5, [x17]
               	sub	x17, x29, #0x4b0
               	str	w6, [x17]
               	sub	x17, x29, #0x4ac
               	str	w7, [x17]
               	sub	x17, x29, #0x4a8
               	str	w8, [x17]
               	sub	x17, x29, #0x4a4
               	str	w9, [x17]
               	ldr	w3, [x0, #0xc]
               	and	x5, x25, #0xffffffff00000000
               	orr	x5, x5, x3
               	mov	w5, w5
               	orr	x25, x5, x3, lsl #32
               	ldr	w3, [x0, #0x10]
               	and	x5, x26, #0xffffffff00000000
               	orr	x5, x5, x3
               	mov	w5, w5
               	orr	x26, x5, x3, lsl #32
               	ldr	w3, [x0, #0x14]
               	and	x5, x27, #0xffffffff00000000
               	orr	x5, x5, x3
               	mov	w5, w5
               	orr	x27, x5, x3, lsl #32
               	str	x25, [sp, #0x4b50]
               	str	x26, [sp, #0x4b58]
               	str	x27, [sp, #0x4b60]
               	sub	x3, x29, #0x4d8
               	sub	x5, x29, #0xfb8
               	str	x1, [sp, #0x4308]
               	str	x2, [sp, #0x4300]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x5]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x5, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xfb8
               	add	x2, x2, x0, lsl #3
               	ldr	w3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x16, x29, #0xfb8
               	ldr	w0, [x16]
               	sub	x16, x29, #0xfb4
               	ldr	w1, [x16]
               	sub	x16, x29, #0xfb0
               	ldr	w2, [x16]
               	sub	x16, x29, #0xfac
               	ldr	w3, [x16]
               	sub	x16, x29, #0xfa8
               	ldr	w5, [x16]
               	sub	x16, x29, #0xfa4
               	ldr	w6, [x16]
               	str	w0, [x4]
               	str	w2, [x4, #0x4]
               	str	w5, [x4, #0x8]
               	str	w1, [x4, #0xc]
               	str	w3, [x4, #0x10]
               	str	w6, [x4, #0x14]
               	add	x0, x4, #0x18
               	sub	x1, x29, #0xfd0
               	sub	x2, x29, #0xc70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xc70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xfa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x4, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xfa0
               	add	x2, x2, x0, lsl #3
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	str	d3, [sp, #0x5640]
               	str	d5, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x4c0
               	str	w1, [x17]
               	sub	x17, x29, #0x4bc
               	str	w2, [x17]
               	sub	x17, x29, #0x4b8
               	str	w3, [x17]
               	sub	x17, x29, #0x4b4
               	str	w5, [x17]
               	sub	x17, x29, #0x4b0
               	str	w6, [x17]
               	sub	x17, x29, #0x4ac
               	str	w7, [x17]
               	sub	x17, x29, #0x4a8
               	str	w8, [x17]
               	sub	x17, x29, #0x4a4
               	str	w9, [x17]
               	ldr	w1, [x0, #0xc]
               	and	x2, x20, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x20, x2, x1, lsl #32
               	ldr	w1, [x0, #0x10]
               	and	x2, x22, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x22, x2, x1, lsl #32
               	ldr	w1, [x0, #0x14]
               	and	x2, x23, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x23, x2, x1, lsl #32
               	ldr	w1, [x0, #0x18]
               	and	x2, x24, #0xffffffff00000000
               	orr	x2, x2, x1
               	mov	w2, w2
               	orr	x24, x2, x1, lsl #32
               	str	x20, [sp, #0x5420]
               	str	x22, [sp, #0x5428]
               	str	x23, [sp, #0x5430]
               	str	x24, [sp, #0x5438]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x6c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x6c0
               	add	x2, x2, x0, lsl #3
               	ldr	w3, [x1, x0, lsl #2]
               	str	w3, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x6c0
               	sub	x1, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x6e0
               	sub	x1, x29, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5440]
               	ldr	d1, [sp, #0x5450]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldr	d1, [sp, #0x59e0]
               	ldr	d2, [sp, #0x59f0]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldr	d2, [sp, #0x59e8]
               	ldr	d3, [sp, #0x59f8]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	str	d3, [x4]
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [x4, #0x8]
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [x4, #0x10]
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x120
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x120
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x6a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x6a0
               	add	x2, x2, x0, lsl #3
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x3430]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3440]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xab0]
               	str	w2, [sp, #0xab4]
               	str	w3, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3450]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3454]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3458]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x345c]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3460]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3464]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3468]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x346c]
               	ldr	q0, [sp, #0x3450]
               	ldr	q1, [sp, #0x3460]
               	str	q0, [sp, #0x13c0]
               	str	q1, [sp, #0x13d0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x740
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x740
               	add	x2, x2, x0, lsl #4
               	ldr	w3, [x1, x0, lsl #2]
               	str	w3, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x740
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x720
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x720
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x6b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1400]
               	ldr	q1, [sp, #0x1410]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x4]
               	ldr	q0, [sp, #0x3470]
               	ldr	q1, [sp, #0x3480]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x760
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x690
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x690
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x700
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x700
               	add	x2, x2, x0, lsl #4
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w2, [x0]
               	str	w2, [sp, #0x34b0]
               	ldr	w2, [x0, #0x4]
               	str	w2, [sp, #0x34c0]
               	ldr	w2, [x0, #0x8]
               	str	w2, [sp, #0x34d0]
               	ldr	w2, [x0, #0xc]
               	str	w2, [sp, #0x34b4]
               	ldr	w2, [x0, #0x10]
               	str	w2, [sp, #0x34c4]
               	ldr	w2, [x0, #0x14]
               	str	w2, [sp, #0x34d4]
               	ldr	w2, [x0, #0x18]
               	str	w2, [sp, #0x34b8]
               	ldr	w2, [x0, #0x1c]
               	str	w2, [sp, #0x34c8]
               	ldr	w2, [x0, #0x20]
               	str	w2, [sp, #0x34d8]
               	ldr	w2, [x0, #0x24]
               	str	w2, [sp, #0x34bc]
               	ldr	w2, [x0, #0x28]
               	str	w2, [sp, #0x34cc]
               	ldr	w2, [x0, #0x2c]
               	str	w2, [sp, #0x34dc]
               	ldr	q0, [sp, #0x34b0]
               	ldr	q1, [sp, #0x34c0]
               	ldr	q2, [sp, #0x34d0]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w2, [sp, #0xab0]
               	str	w3, [sp, #0xab4]
               	str	w4, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	str	w10, [sp, #0xad0]
               	str	w11, [sp, #0xad4]
               	str	w12, [sp, #0xad8]
               	str	w13, [sp, #0xadc]
               	ldr	w2, [x0, #0xc]
               	str	w2, [sp, #0x34e0]
               	ldr	w2, [x0, #0xc]
               	str	w2, [sp, #0x34e4]
               	ldr	w2, [x0, #0xc]
               	str	w2, [sp, #0x34e8]
               	ldr	w2, [x0, #0xc]
               	str	w2, [sp, #0x34ec]
               	ldr	w2, [x0, #0x10]
               	str	w2, [sp, #0x34f0]
               	ldr	w2, [x0, #0x10]
               	str	w2, [sp, #0x34f4]
               	ldr	w2, [x0, #0x10]
               	str	w2, [sp, #0x34f8]
               	ldr	w2, [x0, #0x10]
               	str	w2, [sp, #0x34fc]
               	ldr	w2, [x0, #0x14]
               	str	w2, [sp, #0x3500]
               	ldr	w2, [x0, #0x14]
               	str	w2, [sp, #0x3504]
               	ldr	w2, [x0, #0x14]
               	str	w2, [sp, #0x3508]
               	ldr	w2, [x0, #0x14]
               	str	w2, [sp, #0x350c]
               	ldr	q0, [sp, #0x34e0]
               	ldr	q1, [sp, #0x34f0]
               	ldr	q2, [sp, #0x3500]
               	str	q0, [sp, #0x1440]
               	str	q1, [sp, #0x1450]
               	str	q2, [sp, #0x1460]
               	add	x2, sp, #0xa70
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x6b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x6b0
               	add	x3, x3, x0, lsl #4
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	w0, [sp, #0x1470]
               	ldr	w2, [sp, #0x1474]
               	ldr	w3, [sp, #0x1478]
               	ldr	w4, [sp, #0x147c]
               	ldr	w5, [sp, #0x1480]
               	ldr	w6, [sp, #0x1484]
               	ldr	w7, [sp, #0x1488]
               	ldr	w8, [sp, #0x148c]
               	ldr	w9, [sp, #0x1490]
               	ldr	w10, [sp, #0x1494]
               	ldr	w11, [sp, #0x1498]
               	ldr	w12, [sp, #0x149c]
               	str	w0, [x1]
               	str	w5, [x1, #0x4]
               	str	w9, [x1, #0x8]
               	str	w2, [x1, #0xc]
               	str	w6, [x1, #0x10]
               	str	w10, [x1, #0x14]
               	str	w3, [x1, #0x18]
               	str	w7, [x1, #0x1c]
               	str	w11, [x1, #0x20]
               	str	w4, [x1, #0x24]
               	str	w8, [x1, #0x28]
               	str	w12, [x1, #0x2c]
               	add	x0, x1, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x6e0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x610
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x610
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x680
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x1, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x680
               	add	x2, x2, x0, lsl #4
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3540]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3550]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x3560]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x3570]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x1, x0, #0x4
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x700
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x700
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3580]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3584]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3588]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x358c]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3590]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3594]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3598]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x359c]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x35a0]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x35a4]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x35a8]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x35ac]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x35b0]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x35b4]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x35b8]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x35bc]
               	ldr	q0, [sp, #0x3580]
               	ldr	q1, [sp, #0x3590]
               	ldr	q2, [sp, #0x35a0]
               	ldr	q3, [sp, #0x35b0]
               	str	q0, [sp, #0x14d0]
               	str	q1, [sp, #0x14e0]
               	str	q2, [sp, #0x14f0]
               	str	q3, [sp, #0x1500]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x610
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x610
               	add	x2, x2, x0, lsl #4
               	ldr	w3, [x1, x0, lsl #2]
               	str	w3, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x610
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x5d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x5d0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1550]
               	ldr	q1, [sp, #0x1570]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x35c0]
               	ldr	q2, [sp, #0x35e0]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x35d0]
               	ldr	q3, [sp, #0x35f0]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x4]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x4, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x4, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x4, #0x30]
               	add	x0, x4, #0x40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x650
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x520
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x520
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x590
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x590
               	add	x2, x2, x0, lsl #4
               	ldr	w2, [x2]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	str	d2, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x4b0
               	str	w1, [x17]
               	sub	x17, x29, #0x4ac
               	str	w2, [x17]
               	sub	x17, x29, #0x4a8
               	str	w4, [x17]
               	sub	x17, x29, #0x4a4
               	str	w5, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0xcb0]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0xcb4]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0xcb8]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0xcbc]
               	ldr	x1, [sp, #0x47d0]
               	ldr	x2, [sp, #0x47d8]
               	str	x1, [sp, #0x4590]
               	str	x2, [sp, #0x4598]
               	sub	x1, x29, #0x4d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x570
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x570
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x1, x0, lsl #2]
               	str	s0, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x570
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x580
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x580
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x340
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x45a0]
               	ldr	d1, [sp, #0x45a8]
               	zip1	v0.2s, v0.2s, v1.2s
               	str	d0, [x3]
               	ldr	d0, [sp, #0x47e0]
               	ldr	d1, [sp, #0x47e8]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [x3, #0x8]
               	add	x0, x3, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x590
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x330
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x330
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x3, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x560
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	s0, [x0]
               	sub	x17, x29, #0xc58
               	str	s0, [x17]
               	ldr	s0, [x0, #0x4]
               	sub	x17, x29, #0xc50
               	str	s0, [x17]
               	ldr	s0, [x0, #0x8]
               	sub	x17, x29, #0xc48
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0xc54
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0xc4c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0xc44
               	str	s0, [x17]
               	ldr	x1, [sp, #0x4ec8]
               	ldr	x2, [sp, #0x4ed0]
               	ldr	x4, [sp, #0x4ed8]
               	str	x1, [sp, #0x5648]
               	str	x2, [sp, #0x5650]
               	str	x4, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	sub	x17, x29, #0x4b8
               	str	w1, [x17]
               	sub	x17, x29, #0x4b4
               	str	w2, [x17]
               	sub	x17, x29, #0x4b0
               	str	w4, [x17]
               	sub	x17, x29, #0x4ac
               	str	w5, [x17]
               	sub	x17, x29, #0x4a8
               	str	w6, [x17]
               	sub	x17, x29, #0x4a4
               	str	w7, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0xc40
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0xc3c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0xc38
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0xc34
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0xc30
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0xc2c
               	str	s0, [x17]
               	ldr	x1, [sp, #0x4ee0]
               	ldr	x2, [sp, #0x4ee8]
               	ldr	x4, [sp, #0x4ef0]
               	str	x1, [sp, #0x4b98]
               	str	x2, [sp, #0x4ba0]
               	str	x4, [sp, #0x4ba8]
               	sub	x1, x29, #0x4d8
               	sub	x2, x29, #0xf58
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xf58
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x1, x0, lsl #2]
               	str	s0, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xf58
               	sub	x1, x29, #0xf70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xf70
               	sub	x1, x29, #0xc28
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x16, x29, #0xf70
               	ldr	s0, [x16]
               	str	s0, [x3]
               	sub	x16, x29, #0xc20
               	ldr	s0, [x16]
               	str	s0, [x3, #0x4]
               	sub	x16, x29, #0xc18
               	ldr	s0, [x16]
               	str	s0, [x3, #0x8]
               	sub	x16, x29, #0xc24
               	ldr	s0, [x16]
               	str	s0, [x3, #0xc]
               	sub	x16, x29, #0xc1c
               	ldr	s0, [x16]
               	str	s0, [x3, #0x10]
               	sub	x16, x29, #0xc14
               	ldr	s0, [x16]
               	str	s0, [x3, #0x14]
               	add	x0, x3, #0x18
               	sub	x1, x29, #0xf88
               	sub	x2, x29, #0xc10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xc10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xf40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x3, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xf40
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	str	d3, [sp, #0x5640]
               	str	d5, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d0, [sp, #0x5658]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x4c0
               	str	w1, [x17]
               	sub	x17, x29, #0x4bc
               	str	w2, [x17]
               	sub	x17, x29, #0x4b8
               	str	w4, [x17]
               	sub	x17, x29, #0x4b4
               	str	w5, [x17]
               	sub	x17, x29, #0x4b0
               	str	w6, [x17]
               	sub	x17, x29, #0x4ac
               	str	w7, [x17]
               	sub	x17, x29, #0x4a8
               	str	w8, [x17]
               	sub	x17, x29, #0x4a4
               	str	w9, [x17]
               	ldr	s0, [x0, #0xc]
               	stur	s0, [x29, #-0x100]
               	ldr	s0, [x0, #0xc]
               	stur	s0, [x29, #-0xfc]
               	ldr	s0, [x0, #0x10]
               	stur	s0, [x29, #-0xf8]
               	ldr	s0, [x0, #0x10]
               	stur	s0, [x29, #-0xf4]
               	ldr	s0, [x0, #0x14]
               	stur	s0, [x29, #-0xf0]
               	ldr	s0, [x0, #0x14]
               	stur	s0, [x29, #-0xec]
               	ldr	s0, [x0, #0x18]
               	stur	s0, [x29, #-0xe8]
               	ldr	s0, [x0, #0x18]
               	stur	s0, [x29, #-0xe4]
               	ldur	x1, [x29, #-0x100]
               	ldur	x2, [x29, #-0xf8]
               	ldur	x4, [x29, #-0xf0]
               	ldur	x5, [x29, #-0xe8]
               	str	x1, [sp, #0x54a0]
               	str	x2, [sp, #0x54a8]
               	str	x4, [sp, #0x54b0]
               	str	x5, [sp, #0x54b8]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x640
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x640
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x1, x0, lsl #2]
               	str	s0, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x640
               	sub	x1, x29, #0x660
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x660
               	sub	x1, x29, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x54c0]
               	ldr	d1, [sp, #0x54d0]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldur	d1, [x29, #-0xe0]
               	ldur	d2, [x29, #-0xd0]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldur	d2, [x29, #-0xd8]
               	ldur	d3, [x29, #-0xc8]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	str	d3, [x3]
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [x3, #0x8]
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [x3, #0x10]
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [x3, #0x18]
               	add	x0, x3, #0x20
               	sub	x1, x29, #0x680
               	sub	x2, x29, #0xc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0xc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x620
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x3, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x620
               	add	x2, x2, x0, lsl #3
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x3640]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3650]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xab0]
               	str	w2, [sp, #0xab4]
               	str	w4, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3660]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3664]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3668]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x366c]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3670]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3674]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3678]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x367c]
               	ldr	q0, [sp, #0x3660]
               	ldr	q1, [sp, #0x3670]
               	str	q0, [sp, #0x15d0]
               	str	q1, [sp, #0x15e0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x530
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x530
               	add	x2, x2, x0, lsl #4
               	ldr	s0, [x1, x0, lsl #2]
               	str	s0, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x530
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x510
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x510
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x4a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1610]
               	ldr	q1, [sp, #0x1620]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x3]
               	ldr	q0, [sp, #0x3680]
               	ldr	q1, [sp, #0x3690]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x3, #0x10]
               	add	x0, x3, #0x20
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x480
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x480
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x4f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x3, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x4f0
               	add	x2, x2, x0, lsl #4
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x0]
               	str	s0, [sp, #0x36c0]
               	ldr	s0, [x0, #0x4]
               	str	s0, [sp, #0x36d0]
               	ldr	s0, [x0, #0x8]
               	str	s0, [sp, #0x36e0]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36c4]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36d4]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36e4]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x36c8]
               	ldr	s0, [x0, #0x1c]
               	str	s0, [sp, #0x36d8]
               	ldr	s0, [x0, #0x20]
               	str	s0, [sp, #0x36e8]
               	ldr	s0, [x0, #0x24]
               	str	s0, [sp, #0x36cc]
               	ldr	s0, [x0, #0x28]
               	str	s0, [sp, #0x36dc]
               	ldr	s0, [x0, #0x2c]
               	str	s0, [sp, #0x36ec]
               	ldr	q0, [sp, #0x36c0]
               	ldr	q1, [sp, #0x36d0]
               	ldr	q2, [sp, #0x36e0]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w2, [sp, #0xab0]
               	str	w3, [sp, #0xab4]
               	str	w4, [sp, #0xab8]
               	str	w5, [sp, #0xabc]
               	str	w6, [sp, #0xac0]
               	str	w7, [sp, #0xac4]
               	str	w8, [sp, #0xac8]
               	str	w9, [sp, #0xacc]
               	str	w10, [sp, #0xad0]
               	str	w11, [sp, #0xad4]
               	str	w12, [sp, #0xad8]
               	str	w13, [sp, #0xadc]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36f0]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36f4]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36f8]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36fc]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3700]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3704]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3708]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x370c]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x3710]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x3714]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x3718]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x371c]
               	ldr	q0, [sp, #0x36f0]
               	ldr	q1, [sp, #0x3700]
               	ldr	q2, [sp, #0x3710]
               	str	q0, [sp, #0x1650]
               	str	q1, [sp, #0x1660]
               	str	q2, [sp, #0x1670]
               	add	x2, sp, #0xa70
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x4a0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x4a0
               	add	x3, x3, x0, lsl #4
               	ldr	s0, [x2, x0, lsl #2]
               	str	s0, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x4a0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x470
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x470
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x400
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldr	s0, [sp, #0x16b0]
               	str	s0, [x1]
               	ldr	s0, [sp, #0x3730]
               	str	s0, [x1, #0x4]
               	ldr	s0, [sp, #0x3740]
               	str	s0, [x1, #0x8]
               	ldr	s0, [sp, #0x3724]
               	str	s0, [x1, #0xc]
               	ldr	s0, [sp, #0x3734]
               	str	s0, [x1, #0x10]
               	ldr	s0, [sp, #0x3744]
               	str	s0, [x1, #0x14]
               	ldr	s0, [sp, #0x3728]
               	str	s0, [x1, #0x18]
               	ldr	s0, [sp, #0x3738]
               	str	s0, [x1, #0x1c]
               	ldr	s0, [sp, #0x3748]
               	str	s0, [x1, #0x20]
               	ldr	s0, [sp, #0x372c]
               	str	s0, [x1, #0x24]
               	ldr	s0, [sp, #0x373c]
               	str	s0, [x1, #0x28]
               	ldr	s0, [sp, #0x374c]
               	str	s0, [x1, #0x2c]
               	add	x0, x1, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x4d0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x3d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x3d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x440
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x1, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x440
               	add	x2, x2, x0, lsl #4
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3780]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3790]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x37a0]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x37b0]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	add	x1, x0, #0x4
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x6c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x6c0
               	add	x2, sp, #0xab0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x37c0]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x37c4]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x37c8]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x37cc]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37d0]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37d4]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37d8]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37dc]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37e0]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37e4]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37e8]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37ec]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37f0]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37f4]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37f8]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37fc]
               	ldr	q0, [sp, #0x37c0]
               	ldr	q1, [sp, #0x37d0]
               	ldr	q2, [sp, #0x37e0]
               	ldr	q3, [sp, #0x37f0]
               	str	q0, [sp, #0x1710]
               	str	q1, [sp, #0x1720]
               	str	q2, [sp, #0x1730]
               	str	q3, [sp, #0x1740]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x3d0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x14
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x3d0
               	add	x2, x2, x0, lsl #4
               	ldr	s0, [x1, x0, lsl #2]
               	str	s0, [x2, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x3d0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x390
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x390
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x320
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1790]
               	ldr	q1, [sp, #0x17b0]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x3800]
               	ldr	q2, [sp, #0x3820]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x3810]
               	ldr	q3, [sp, #0x3830]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x3]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x3, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x3, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x3, #0x30]
               	add	x0, x3, #0x40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x410
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x2e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x2e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x350
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x3, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x350
               	add	x2, x2, x0, lsl #4
               	ldr	s0, [x2]
               	str	s0, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	str	x1, [sp, #0x5650]
               	str	x2, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5670]
               	str	x2, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	str	x1, [sp, #0x45d0]
               	str	x2, [sp, #0x45d8]
               	sub	x1, x29, #0x4d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x540
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x540
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	x0, [sp, #0x45e0]
               	ldr	x1, [sp, #0x45e8]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x550
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x320
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x320
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x530
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x530
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	str	x1, [sp, #0x5648]
               	str	x2, [sp, #0x5650]
               	str	x3, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5668]
               	str	x2, [sp, #0x5670]
               	str	x3, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	str	x1, [sp, #0x4bf8]
               	str	x2, [sp, #0x4c00]
               	str	x3, [sp, #0x4c08]
               	sub	x1, x29, #0x4d8
               	sub	x2, x29, #0xf10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xf10
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4c10]
               	ldr	x1, [sp, #0x4c18]
               	ldr	x2, [sp, #0x4c20]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	add	x0, x4, #0x18
               	sub	x1, x29, #0xf28
               	sub	x2, x29, #0xbf8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xbf8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xef8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x4, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xef8
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	str	x1, [sp, #0x5640]
               	str	x2, [sp, #0x5648]
               	str	x3, [sp, #0x5650]
               	str	x5, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0x5660]
               	str	x2, [sp, #0x5668]
               	str	x3, [sp, #0x5670]
               	str	x5, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	ldr	x5, [x0, #0x30]
               	str	x1, [sp, #0x5520]
               	str	x2, [sp, #0x5528]
               	str	x3, [sp, #0x5530]
               	str	x5, [sp, #0x5538]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x5e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x5e0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x5540]
               	ldr	x1, [sp, #0x5548]
               	ldr	x2, [sp, #0x5550]
               	ldr	x3, [sp, #0x5558]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	str	x3, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x600
               	sub	x2, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x5c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x5c0
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3880]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3890]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x38a0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x38a8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x38b0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x38b8]
               	ldr	q0, [sp, #0x38a0]
               	ldr	q1, [sp, #0x38b0]
               	str	q0, [sp, #0x1810]
               	str	q1, [sp, #0x1820]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x2f0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x2f0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x2f0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x2d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x2d0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x260
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1850]
               	ldr	q1, [sp, #0x1860]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x4]
               	ldr	q0, [sp, #0x38c0]
               	ldr	q1, [sp, #0x38d0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x310
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x2b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x2b0
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x3900]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x3910]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x3920]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3908]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3918]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3928]
               	ldr	q0, [sp, #0x3900]
               	ldr	q1, [sp, #0x3910]
               	ldr	q2, [sp, #0x3920]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3930]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3938]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3940]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3948]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3950]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3958]
               	ldr	q0, [sp, #0x3930]
               	ldr	q1, [sp, #0x3940]
               	ldr	q2, [sp, #0x3950]
               	str	q0, [sp, #0x1890]
               	str	q1, [sp, #0x18a0]
               	str	q2, [sp, #0x18b0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x260
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x260
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x18c0]
               	ldr	x1, [sp, #0x18c8]
               	ldr	x2, [sp, #0x18d0]
               	ldr	x3, [sp, #0x18d8]
               	ldr	x5, [sp, #0x18e0]
               	ldr	x6, [sp, #0x18e8]
               	str	x0, [x4]
               	str	x2, [x4, #0x8]
               	str	x5, [x4, #0x10]
               	str	x1, [x4, #0x18]
               	str	x3, [x4, #0x20]
               	str	x6, [x4, #0x28]
               	add	x0, x4, #0x30
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x290
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x1c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x1c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x230
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x4, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x230
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3990]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x39a0]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x39b0]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x39c0]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	str	x8, [sp, #0xae0]
               	str	x9, [sp, #0xae8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x39d0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x39d8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x39e0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x39e8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x39f0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x39f8]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3a00]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3a08]
               	ldr	q0, [sp, #0x39d0]
               	ldr	q1, [sp, #0x39e0]
               	ldr	q2, [sp, #0x39f0]
               	ldr	q3, [sp, #0x3a00]
               	str	q0, [sp, #0x1920]
               	str	q1, [sp, #0x1930]
               	str	q2, [sp, #0x1940]
               	str	q3, [sp, #0x1950]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x1c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x1c0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x1c0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x180
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x180
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x110
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x19a0]
               	ldr	q1, [sp, #0x19c0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x3a10]
               	ldr	q2, [sp, #0x3a30]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x3a20]
               	ldr	q3, [sp, #0x3a40]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x4]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x4, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x30]
               	add	x0, x4, #0x40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x200
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xd0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xd0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x140
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	str	x1, [sp, #0x5650]
               	str	x2, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5670]
               	str	x2, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	str	x1, [sp, #0x4600]
               	str	x2, [sp, #0x4608]
               	sub	x1, x29, #0x4d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x510
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x510
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4610]
               	ldr	x1, [sp, #0x4618]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x520
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x310
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x310
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x500
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x500
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	str	x1, [sp, #0x5648]
               	str	x2, [sp, #0x5650]
               	str	x3, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5668]
               	str	x2, [sp, #0x5670]
               	str	x3, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	str	x1, [sp, #0x4c40]
               	str	x2, [sp, #0x4c48]
               	str	x3, [sp, #0x4c50]
               	sub	x1, x29, #0x4d8
               	sub	x2, x29, #0xec8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xec8
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4c58]
               	ldr	x1, [sp, #0x4c60]
               	ldr	x2, [sp, #0x4c68]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	add	x0, x4, #0x18
               	sub	x1, x29, #0xee0
               	sub	x2, x29, #0xbe0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xbe0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xeb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x4, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xeb0
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	str	x1, [sp, #0x5640]
               	str	x2, [sp, #0x5648]
               	str	x3, [sp, #0x5650]
               	str	x5, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0x5660]
               	str	x2, [sp, #0x5668]
               	str	x3, [sp, #0x5670]
               	str	x5, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	ldr	x5, [x0, #0x30]
               	str	x1, [sp, #0x5580]
               	str	x2, [sp, #0x5588]
               	str	x3, [sp, #0x5590]
               	str	x5, [sp, #0x5598]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x580
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x580
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x55a0]
               	ldr	x1, [sp, #0x55a8]
               	ldr	x2, [sp, #0x55b0]
               	ldr	x3, [sp, #0x55b8]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	str	x3, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x5a0
               	sub	x2, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x560
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3a90]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3aa0]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3ab0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3ab8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3ac0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3ac8]
               	ldr	q0, [sp, #0x3ab0]
               	ldr	q1, [sp, #0x3ac0]
               	str	q0, [sp, #0x1a20]
               	str	q1, [sp, #0x1a30]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xe0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xe0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xe0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xc0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1a60]
               	ldr	q1, [sp, #0x1a70]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x4]
               	ldr	q0, [sp, #0x3ad0]
               	ldr	q1, [sp, #0x3ae0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x100
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xa0
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x3b10]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x3b20]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x3b30]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3b18]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3b28]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b38]
               	ldr	q0, [sp, #0x3b10]
               	ldr	q1, [sp, #0x3b20]
               	ldr	q2, [sp, #0x3b30]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3b40]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3b48]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3b50]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3b58]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b60]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b68]
               	ldr	q0, [sp, #0x3b40]
               	ldr	q1, [sp, #0x3b50]
               	ldr	q2, [sp, #0x3b60]
               	str	q0, [sp, #0x1aa0]
               	str	q1, [sp, #0x1ab0]
               	str	q2, [sp, #0x1ac0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x50
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x1ad0]
               	ldr	x1, [sp, #0x1ad8]
               	ldr	x2, [sp, #0x1ae0]
               	ldr	x3, [sp, #0x1ae8]
               	ldr	x5, [sp, #0x1af0]
               	ldr	x6, [sp, #0x1af8]
               	str	x0, [x4]
               	str	x2, [x4, #0x8]
               	str	x5, [x4, #0x10]
               	str	x1, [x4, #0x18]
               	str	x3, [x4, #0x20]
               	str	x6, [x4, #0x28]
               	add	x0, x4, #0x30
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x80
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xfb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xfb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x4, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x20
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3ba0]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3bb0]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3bc0]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3bd0]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	str	x8, [sp, #0xae0]
               	str	x9, [sp, #0xae8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3be0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3be8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3bf0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3bf8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3c00]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3c08]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3c10]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3c18]
               	ldr	q0, [sp, #0x3be0]
               	ldr	q1, [sp, #0x3bf0]
               	ldr	q2, [sp, #0x3c00]
               	ldr	q3, [sp, #0x3c10]
               	str	q0, [sp, #0x1b30]
               	str	q1, [sp, #0x1b40]
               	str	q2, [sp, #0x1b50]
               	str	q3, [sp, #0x1b60]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xfb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xfb0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xfb0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xf70
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xf00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1bb0]
               	ldr	q1, [sp, #0x1bd0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x3c20]
               	ldr	q2, [sp, #0x3c40]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x3c30]
               	ldr	q3, [sp, #0x3c50]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x4]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x4, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x30]
               	add	x0, x4, #0x40
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xff0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xec0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xec0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xf30
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	str	x1, [sp, #0x5650]
               	str	x2, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5670]
               	str	x2, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	str	x1, [sp, #0x4630]
               	str	x2, [sp, #0x4638]
               	sub	x1, x29, #0x4d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x4e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x4e0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4640]
               	ldr	x1, [sp, #0x4648]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	add	x0, x4, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4f0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x300
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x300
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x4, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x4d0
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	str	x1, [sp, #0x5648]
               	str	x2, [sp, #0x5650]
               	str	x3, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5668]
               	str	x2, [sp, #0x5670]
               	str	x3, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	str	x1, [sp, #0x4c88]
               	str	x2, [sp, #0x4c90]
               	str	x3, [sp, #0x4c98]
               	sub	x1, x29, #0x4d8
               	sub	x2, x29, #0xe80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe80
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4ca0]
               	ldr	x1, [sp, #0x4ca8]
               	ldr	x2, [sp, #0x4cb0]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	add	x0, x4, #0x18
               	sub	x1, x29, #0xe98
               	sub	x2, x29, #0xbc8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xbc8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xe68
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x4, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe68
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	str	x1, [sp, #0x5640]
               	str	x2, [sp, #0x5648]
               	str	x3, [sp, #0x5650]
               	str	x5, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0x5660]
               	str	x2, [sp, #0x5668]
               	str	x3, [sp, #0x5670]
               	str	x5, [sp, #0x5678]
               	ldr	x1, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	ldr	x3, [x0, #0x28]
               	ldr	x5, [x0, #0x30]
               	str	x1, [sp, #0x55e0]
               	str	x2, [sp, #0x55e8]
               	str	x3, [sp, #0x55f0]
               	str	x5, [sp, #0x55f8]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x520
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x520
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x5600]
               	ldr	x1, [sp, #0x5608]
               	ldr	x2, [sp, #0x5610]
               	ldr	x3, [sp, #0x5618]
               	str	x0, [x4]
               	str	x1, [x4, #0x8]
               	str	x2, [x4, #0x10]
               	str	x3, [x4, #0x18]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x540
               	sub	x2, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x500
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x500
               	ldr	x2, [x2, x0, lsl #3]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3ca0]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3cb0]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3cc0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3cc8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3cd0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3cd8]
               	ldr	q0, [sp, #0x3cc0]
               	ldr	q1, [sp, #0x3cd0]
               	str	q0, [sp, #0x1c30]
               	str	q1, [sp, #0x1c40]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xed0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xed0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xed0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xeb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xeb0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xe40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1c70]
               	ldr	q1, [sp, #0x1c80]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x4]
               	ldr	q0, [sp, #0x3ce0]
               	ldr	q1, [sp, #0x3cf0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x4, #0x10]
               	add	x0, x4, #0x20
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xef0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xe20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xe20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x4, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xe90
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x3d20]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x3d30]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x3d40]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3d28]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d38]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d48]
               	ldr	q0, [sp, #0x3d20]
               	ldr	q1, [sp, #0x3d30]
               	ldr	q2, [sp, #0x3d40]
               	str	q0, [sp, #0xa70]
               	str	q1, [sp, #0xa80]
               	str	q2, [sp, #0xa90]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3d50]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3d58]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d60]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d68]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d70]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d78]
               	ldr	q0, [sp, #0x3d50]
               	ldr	q1, [sp, #0x3d60]
               	ldr	q2, [sp, #0x3d70]
               	str	q0, [sp, #0x1cb0]
               	str	q1, [sp, #0x1cc0]
               	str	q2, [sp, #0x1cd0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xe40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xe40
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x1ce0]
               	ldr	x1, [sp, #0x1ce8]
               	ldr	x2, [sp, #0x1cf0]
               	ldr	x3, [sp, #0x1cf8]
               	ldr	x5, [sp, #0x1d00]
               	ldr	x6, [sp, #0x1d08]
               	str	x0, [x4]
               	str	x2, [x4, #0x8]
               	str	x5, [x4, #0x10]
               	str	x1, [x4, #0x18]
               	str	x3, [x4, #0x20]
               	str	x6, [x4, #0x28]
               	add	x0, x4, #0x30
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe70
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xda0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xda0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x4, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xe10
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3db0]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3dc0]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3dd0]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3de0]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x3, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	str	x8, [sp, #0xae0]
               	str	x9, [sp, #0xae8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3df0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3df8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3e00]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3e08]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3e10]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3e18]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3e20]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3e28]
               	ldr	q0, [sp, #0x3df0]
               	ldr	q1, [sp, #0x3e00]
               	ldr	q2, [sp, #0x3e10]
               	ldr	q3, [sp, #0x3e20]
               	str	q0, [sp, #0x1d40]
               	str	q1, [sp, #0x1d50]
               	str	q2, [sp, #0x1d60]
               	str	q3, [sp, #0x1d70]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xda0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xda0
               	add	x2, x2, x0, lsl #4
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xda0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xd60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xd60
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xcf0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1dc0]
               	ldr	q1, [sp, #0x1de0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x3e30]
               	ldr	q2, [sp, #0x3e50]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x3e40]
               	ldr	q3, [sp, #0x3e60]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x4]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x4, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x4, #0x30]
               	add	x0, x4, #0x40
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xde0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xcb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xcb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xd20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x4, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xd20
               	add	x2, x2, x0, lsl #4
               	ldr	x2, [x2]
               	str	x2, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	str	d0, [sp, #0x5650]
               	str	d1, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5670]
               	str	x2, [sp, #0x5678]
               	ldr	d0, [x0, #0x18]
               	ldr	d1, [x0, #0x20]
               	str	d0, [sp, #0x4660]
               	str	d1, [sp, #0x4668]
               	sub	x1, x29, #0x4d0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x4a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x4a0
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4a0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4670]
               	str	d0, [x3]
               	ldr	d0, [sp, #0x4838]
               	str	d0, [x3, #0x8]
               	add	x0, x3, #0x10
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4c0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x4b0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x490
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x3, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x490
               	ldr	d0, [x2, x0, lsl #3]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x4b0
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	str	d0, [sp, #0x5648]
               	str	d1, [sp, #0x5650]
               	str	d2, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	str	x1, [sp, #0x5668]
               	str	x2, [sp, #0x5670]
               	str	x4, [sp, #0x5678]
               	ldr	d0, [x0, #0x18]
               	ldr	d1, [x0, #0x20]
               	ldr	d2, [x0, #0x28]
               	str	d0, [sp, #0x4cd0]
               	str	d1, [sp, #0x4cd8]
               	str	d2, [sp, #0x4ce0]
               	sub	x1, x29, #0x4d8
               	sub	x2, x29, #0xe20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe20
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xe20
               	sub	x1, x29, #0xe38
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xe38
               	sub	x1, x29, #0xbb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	ldr	d0, [sp, #0x4ce8]
               	str	d0, [x3]
               	ldr	d0, [sp, #0x4f78]
               	str	d0, [x3, #0x8]
               	ldr	d0, [sp, #0x4f80]
               	str	d0, [x3, #0x10]
               	add	x0, x3, #0x18
               	sub	x1, x29, #0xe50
               	sub	x2, x29, #0xb98
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x1, x29, #0xb98
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0xe08
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x1, x3, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xe08
               	ldr	d0, [x2, x0, lsl #3]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4d8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	sub	x0, x29, #0x4b8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	str	d0, [sp, #0x5640]
               	str	d1, [sp, #0x5648]
               	str	d2, [sp, #0x5650]
               	str	d3, [sp, #0x5658]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0x5660]
               	str	x2, [sp, #0x5668]
               	str	x4, [sp, #0x5670]
               	str	x5, [sp, #0x5678]
               	ldr	d0, [x0, #0x18]
               	ldr	d1, [x0, #0x20]
               	ldr	d2, [x0, #0x28]
               	ldr	d3, [x0, #0x30]
               	str	d0, [sp, #0x5680]
               	str	d1, [sp, #0x5688]
               	str	d2, [sp, #0x5690]
               	str	d3, [sp, #0x5698]
               	sub	x1, x29, #0x4e0
               	sub	x2, x29, #0x460
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x460
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x480
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x480
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x56a0]
               	str	d0, [x3]
               	ldur	d0, [x29, #-0x38]
               	str	d0, [x3, #0x8]
               	ldur	d0, [x29, #-0x30]
               	str	d0, [x3, #0x10]
               	ldur	d0, [x29, #-0x28]
               	str	d0, [x3, #0x18]
               	add	x0, x3, #0x20
               	sub	x1, x29, #0x4a0
               	sub	x2, x29, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x4c0
               	sub	x1, x29, #0x440
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x3, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x440
               	ldr	d0, [x2, x0, lsl #3]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	sub	x0, x29, #0x4e0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sub	x0, x29, #0x4c0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3eb0]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3ec0]
               	str	q2, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x4, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x3ed0]
               	ldr	d1, [x0, #0x18]
               	str	d1, [sp, #0x3ed8]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x3ee0]
               	ldr	d3, [x0, #0x20]
               	str	d3, [sp, #0x3ee8]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	str	q0, [sp, #0x1e40]
               	str	q1, [sp, #0x1e50]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xcc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xcc0
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xcc0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xca0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xca0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xc30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1e80]
               	ldr	q1, [sp, #0x1e90]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x3]
               	ldr	q0, [sp, #0x3ef0]
               	ldr	q1, [sp, #0x3f00]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x3, #0x10]
               	add	x0, x3, #0x20
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xce0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xc10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xc10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x3, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xc80
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x2]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x0]
               	str	d0, [sp, #0x3f30]
               	ldr	d0, [x0, #0x8]
               	str	d0, [sp, #0x3f40]
               	ldr	d1, [x0, #0x10]
               	str	d1, [sp, #0x3f50]
               	ldr	d2, [x0, #0x18]
               	str	d2, [sp, #0x3f38]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x3f48]
               	ldr	d3, [x0, #0x28]
               	str	d3, [sp, #0x3f58]
               	ldr	q4, [sp, #0x3f30]
               	mov	v0.d[1], v2.d[0]
               	mov	v1.d[1], v3.d[0]
               	str	q4, [sp, #0xa70]
               	str	q0, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x4, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x3f60]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x3f68]
               	ldr	d0, [x0, #0x20]
               	str	d0, [sp, #0x3f70]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x3f78]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x3f80]
               	ldr	d3, [x0, #0x28]
               	str	d3, [sp, #0x3f88]
               	ldr	q4, [sp, #0x3f60]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	str	q4, [sp, #0x1ec0]
               	str	q0, [sp, #0x1ed0]
               	str	q1, [sp, #0x1ee0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xc30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xc30
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xc30
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xc00
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xb90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldr	d0, [sp, #0x1f20]
               	str	d0, [x3]
               	ldr	d0, [sp, #0x3fa0]
               	str	d0, [x3, #0x8]
               	ldr	d0, [sp, #0x3fb0]
               	str	d0, [x3, #0x10]
               	ldr	d0, [sp, #0x3f98]
               	str	d0, [x3, #0x18]
               	ldr	d0, [sp, #0x3fa8]
               	str	d0, [x3, #0x20]
               	ldr	d0, [sp, #0x3fb8]
               	str	d0, [x3, #0x28]
               	add	x0, x3, #0x30
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc60
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xb60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xb60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xbd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xbd0
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x2]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x30               // =48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3ff0]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x4000]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x4010]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x4020]
               	str	q3, [sp, #0xa70]
               	str	q5, [sp, #0xa80]
               	str	q1, [sp, #0xa90]
               	str	q0, [sp, #0xaa0]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xab0]
               	str	x2, [sp, #0xab8]
               	str	x4, [sp, #0xac0]
               	str	x5, [sp, #0xac8]
               	str	x6, [sp, #0xad0]
               	str	x7, [sp, #0xad8]
               	str	x8, [sp, #0xae0]
               	str	x9, [sp, #0xae8]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4030]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4038]
               	ldr	d0, [x0, #0x20]
               	str	d0, [sp, #0x4040]
               	ldr	d0, [x0, #0x20]
               	str	d0, [sp, #0x4048]
               	ldr	d0, [x0, #0x28]
               	str	d0, [sp, #0x4050]
               	ldr	d1, [x0, #0x28]
               	str	d1, [sp, #0x4058]
               	ldr	d2, [x0, #0x30]
               	str	d2, [sp, #0x4060]
               	ldr	d3, [x0, #0x30]
               	str	d3, [sp, #0x4068]
               	ldr	q4, [sp, #0x4030]
               	ldr	q5, [sp, #0x4040]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	str	q4, [sp, #0x1f80]
               	str	q5, [sp, #0x1f90]
               	str	q0, [sp, #0x1fa0]
               	str	q1, [sp, #0x1fb0]
               	add	x1, sp, #0xa70
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xb60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x1, x0, #0x28
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xb60
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x1, x0, lsl #3]
               	str	d0, [x2, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xb60
               	add	x1, sp, #0x2, lsl #12   // =0x2000
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x2, lsl #12   // =0x2000
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xab0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x2000]
               	ldr	q1, [sp, #0x2020]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x4070]
               	ldr	q2, [sp, #0x4090]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4080]
               	ldr	q3, [sp, #0x40a0]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x3]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x3, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x3, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x3, #0x30]
               	add	x0, x3, #0x40
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xba0
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xa70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xa70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, sp, #0xab0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xae0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x3, #0x80
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xae0
               	add	x2, x2, x0, lsl #4
               	ldr	d0, [x2]
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa70
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x0, sp, #0xab0
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x64
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x6be0            // =27616
               	movk	x17, #0x6974, lsl #16
               	movk	x17, #0x4a86, lsl #32
               	movk	x17, #0x175c, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5, lsl #12   // =0x5000
               	add	sp, sp, #0xb20
               	ldp	x29, x30, [sp], #0x10
               	ret
