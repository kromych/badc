
arm_neon_lane_ext_pmull_high.aarch64:	file format elf64-littleaarch64

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

<vld1q_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x30
               	str	x1, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<vmull_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x2, x29, #0x40
               	str	x2, [sp, #0x10]
               	fmov	d16, x0
               	str	d16, [sp, #0x18]
               	fmov	d16, x1
               	str	d16, [sp, #0x20]
               	ldr	d1, [sp, #0x18]
               	ldr	d2, [sp, #0x20]
               	pmull	v0.1q, v1.1d, v2.1d
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<vmull_high_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	pmull2	v0.1q, v1.2d, v2.2d
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_u64_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_u8_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_u64_p128>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_p128_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_p64_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vreinterpretq_u64_p64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	q0, [x16]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x3a0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x360
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x188
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	sub	x16, x29, #0x188
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x350
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x170
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	sub	x16, x29, #0x170
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x2, x29, #0x370
               	sub	x1, x29, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	sub	x2, x29, #0x320
               	str	x2, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	str	x1, [sp, #0x1a0]
               	ldr	x16, [sp, #0x198]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1a0]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x8
               	ldr	x16, [sp, #0x190]
               	str	q0, [x16]
               	sub	x1, x29, #0x320
               	sub	x0, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x118
               	str	x0, [sp, #0x190]
               	str	x1, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	sub	x16, x29, #0x118
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x310
               	sub	x0, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x100
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x100]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x310
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x2e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x3, x29, #0x370
               	sub	x1, x29, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x1
               	sub	x3, x29, #0x2c0
               	str	x3, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	str	x1, [sp, #0x1a0]
               	ldr	x16, [sp, #0x198]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1a0]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x0
               	ldr	x16, [sp, #0x190]
               	str	q0, [x16]
               	sub	x0, x29, #0x2c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0x310
               	sub	x0, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xb8
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0xb8]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x310
               	sub	x0, x29, #0x2a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xa0
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0xa0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x380
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1e8
               	str	q0, [x16]
               	sub	x22, x29, #0x1e8
               	sub	x0, x29, #0x370
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1d8
               	str	q0, [x16]
               	sub	x1, x29, #0x1d8
               	ldr	q0, [x22]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	ldr	x22, [x0]
               	ldr	x23, [x0, #0x8]
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0xff00             // =65280
               	movk	x1, #0xddee, lsl #16
               	movk	x1, #0xbbcc, lsl #32
               	movk	x1, #0x99aa, lsl #48
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	ldr	x9, [x0]
               	ldr	x10, [x0, #0x8]
               	mov	x4, #0xcdef             // =52719
               	movk	x4, #0x89ab, lsl #16
               	movk	x4, #0x4567, lsl #32
               	movk	x4, #0x123, lsl #48
               	mov	x5, #0xff00             // =65280
               	movk	x5, #0xddee, lsl #16
               	movk	x5, #0xbbcc, lsl #32
               	movk	x5, #0x99aa, lsl #48
               	sub	x2, x29, #0x1e0
               	sub	x3, x29, #0x1c0
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	mov	x6, #0x1                // =1
               	str	x0, [x3]
               	b	<addr>
               	sxtw	x1, w0
               	lsr	x7, x5, x1
               	and	x7, x7, x6
               	cbz	x7, <addr>
               	ldr	x7, [x2]
               	lsl	x8, x4, x1
               	eor	x7, x7, x8
               	str	x7, [x2]
               	cbz	x1, <addr>
               	ldr	x7, [x3]
               	mov	x8, #0x40               // =64
               	sub	x8, x8, x0
               	sxtw	x8, w8
               	lsr	x8, x4, x8
               	eor	x7, x7, x8
               	str	x7, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x16, x29, #0x1e0
               	ldr	x0, [x16]
               	cmp	x22, x0
               	b.ne	<addr>
               	sub	x16, x29, #0x1c0
               	ldr	x0, [x16]
               	cmp	x23, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x22, x9
               	b.ne	<addr>
               	cmp	x23, x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x380
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1d8
               	str	q0, [x16]
               	sub	x0, x29, #0x1d8
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x1, x29, #0x1c8
               	sub	x0, x29, #0x270
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x78
               	str	x0, [sp, #0x190]
               	str	x1, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x78]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x270
               	sub	x0, x29, #0x250
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x50
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x270
               	sub	x0, x29, #0x370
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1d8
               	str	q0, [x16]
               	sub	x0, x29, #0x1d8
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x1, x29, #0x270
               	sub	x0, x29, #0x240
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x48
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x48]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x270
               	sub	x0, x29, #0x230
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x20
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x20]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x270
               	sub	x0, x29, #0x380
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1d8
               	str	q0, [x16]
               	sub	x0, x29, #0x1d8
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x1c8
               	str	q0, [x16]
               	sub	x0, x29, #0x1c8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x1, x29, #0x270
               	sub	x0, x29, #0x220
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x18
               	str	x1, [sp, #0x190]
               	str	x0, [sp, #0x198]
               	ldr	x16, [sp, #0x198]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x190]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3a0
               	ldp	x29, x30, [sp], #0x10
               	ret
