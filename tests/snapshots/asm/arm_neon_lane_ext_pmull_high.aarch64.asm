
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

<vreinterpretq_u64_u8>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u8_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u64_p128>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_p128_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_p64_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u64_p64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x460
               	stp	x20, x21, [sp]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	sub	x0, x29, #0x2e0
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x0, [sp, #0x1d0]
               	str	x20, [sp, #0x1d8]
               	ldr	x0, [sp, #0x1d8]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x1, x29, #0x2e0
               	sub	x0, x29, #0x238
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x2, x29, #0x450
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x0, [sp, #0x1d8]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x1, x29, #0x2e0
               	sub	x0, x29, #0x238
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x440
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x450
               	sub	x0, x29, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x1f8
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x1f8
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x450
               	sub	x0, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x1e0
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x1e0
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x450
               	sub	x0, x29, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x2, x29, #0x440
               	sub	x1, x29, #0x400
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x1
               	sub	x2, x29, #0x3f0
               	str	d0, [sp, #0x1e8]
               	str	d1, [sp, #0x1f0]
               	str	d2, [sp, #0x1f8]
               	str	x2, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	str	x1, [sp, #0x1e0]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1e0]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x8
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x1e8]
               	ldr	d1, [sp, #0x1f0]
               	ldr	d2, [sp, #0x1f8]
               	sub	x1, x29, #0x3f0
               	sub	x0, x29, #0x3e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x188
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x0, [sp, #0x1d0]
               	str	x1, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x188
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x3e0
               	sub	x0, x29, #0x3c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x170
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x170
               	ldr	x0, [x16]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x3e0
               	sub	x1, x29, #0x450
               	sub	x0, x29, #0x3b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x3, x29, #0x440
               	sub	x1, x29, #0x3a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x1
               	sub	x3, x29, #0x390
               	str	d0, [sp, #0x1e8]
               	str	d1, [sp, #0x1f0]
               	str	d2, [sp, #0x1f8]
               	str	x3, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	str	x1, [sp, #0x1e0]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1e0]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x0
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x1e8]
               	ldr	d1, [sp, #0x1f0]
               	ldr	d2, [sp, #0x1f8]
               	sub	x0, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x1, x29, #0x3e0
               	sub	x0, x29, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x128
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x128
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x3e0
               	sub	x0, x29, #0x370
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x110
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	sub	x16, x29, #0x110
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x21, x29, #0x70
               	sub	x0, x29, #0x440
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x60
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x2b0
               	str	d0, [sp, #0x1e8]
               	str	d1, [sp, #0x1f0]
               	str	d2, [sp, #0x1f8]
               	str	x1, [sp, #0x1d0]
               	str	x21, [sp, #0x1d8]
               	str	x0, [sp, #0x1e0]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1e0]
               	ldr	q2, [x16]
               	pmull2	v0.1q, v1.2d, v2.2d
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x1e8]
               	ldr	d1, [sp, #0x1f0]
               	ldr	d2, [sp, #0x1f8]
               	sub	x0, x29, #0x2b0
               	ldr	x9, [x0]
               	ldr	x10, [x0, #0x8]
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0xff00             // =65280
               	movk	x1, #0xddee, lsl #16
               	movk	x1, #0xbbcc, lsl #32
               	movk	x1, #0x99aa, lsl #48
               	sub	x2, x29, #0x2a0
               	str	d0, [sp, #0x1e8]
               	str	d1, [sp, #0x1f0]
               	str	d2, [sp, #0x1f8]
               	str	x2, [sp, #0x1d0]
               	fmov	d16, x0
               	str	d16, [sp, #0x1d8]
               	fmov	d16, x1
               	str	d16, [sp, #0x1e0]
               	ldr	d1, [sp, #0x1d8]
               	ldr	d2, [sp, #0x1e0]
               	pmull	v0.1q, v1.1d, v2.1d
               	ldr	x16, [sp, #0x1d0]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x1e8]
               	ldr	d1, [sp, #0x1f0]
               	ldr	d2, [sp, #0x1f8]
               	sub	x0, x29, #0x2a0
               	ldr	x11, [x0]
               	ldr	x12, [x0, #0x8]
               	mov	x4, #0xcdef             // =52719
               	movk	x4, #0x89ab, lsl #16
               	movk	x4, #0x4567, lsl #32
               	movk	x4, #0x123, lsl #48
               	mov	x5, #0xff00             // =65280
               	movk	x5, #0xddee, lsl #16
               	movk	x5, #0xbbcc, lsl #32
               	movk	x5, #0x99aa, lsl #48
               	sub	x2, x29, #0x250
               	sub	x3, x29, #0x230
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
               	sub	x16, x29, #0x250
               	ldr	x0, [x16]
               	cmp	x9, x0
               	b.ne	<addr>
               	sub	x16, x29, #0x230
               	ldr	x0, [x16]
               	cmp	x10, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x9, x11
               	b.ne	<addr>
               	cmp	x10, x12
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x248
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x248
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x238
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x238
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xe8
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x0, [sp, #0x1d0]
               	str	x1, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	ldur	x0, [x29, #-0xe8]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x340
               	sub	x0, x29, #0x320
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xc0
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	ldur	x0, [x29, #-0xc0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x340
               	sub	x0, x29, #0x440
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x248
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x248
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x238
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x238
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x1, x29, #0x340
               	sub	x0, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0xb8
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	ldur	x0, [x29, #-0xb8]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x1, x29, #0x340
               	sub	x0, x29, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x90
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	ldur	x0, [x29, #-0x90]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x340
               	sub	x0, x29, #0x450
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x248
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x248
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x238
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x238
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x1, x29, #0x340
               	sub	x0, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x1, x29, #0x88
               	str	x0, [sp, #0x1e0]
               	str	d0, [sp, #0x1e8]
               	str	x1, [sp, #0x1d0]
               	str	x0, [sp, #0x1d8]
               	ldr	x16, [sp, #0x1d8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1d0]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x1e0]
               	ldr	d0, [sp, #0x1e8]
               	ldur	x0, [x29, #-0x88]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x460
               	ldp	x29, x30, [sp], #0x10
               	ret
