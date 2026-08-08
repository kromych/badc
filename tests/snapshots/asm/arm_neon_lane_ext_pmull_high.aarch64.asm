
arm_neon_lane_ext_pmull_high.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<vreinterpretq_u64_u8>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u8_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u64_p128>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_p128_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_p64_u64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<vreinterpretq_u64_p64>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x350
               	stp	x20, x21, [sp]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	sub	x0, x29, #0x30
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x20, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0xe0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0x2b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0xf0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x2d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x2b8
               	sub	x1, x29, #0x2a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x328
               	sub	x1, x29, #0x2a8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x328
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x2b8
               	sub	x1, x29, #0x298
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x320
               	sub	x1, x29, #0x298
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x320
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
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2b8
               	sub	x1, x29, #0x258
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x2d8
               	sub	x1, x29, #0x268
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x278
               	sub	x1, x29, #0x258
               	sub	x2, x29, #0x268
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x8
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x0, x29, #0x278
               	sub	x1, x29, #0x248
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x288
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x288
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x318
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x238
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x310
               	sub	x1, x29, #0x238
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x310
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
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x2b8
               	sub	x2, x29, #0x1f8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x2d8
               	sub	x2, x29, #0x208
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x218
               	sub	x2, x29, #0x1f8
               	sub	x3, x29, #0x208
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	str	x3, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	ext	v0.16b, v1.16b, v2.16b, #0x0
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x218
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x228
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x308
               	sub	x1, x29, #0x228
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x308
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x1e8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x300
               	sub	x1, x29, #0x1e8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x300
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
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2b8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xa0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x21, x29, #0xa0
               	sub	x0, x29, #0x2d8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xb0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0x50
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x1, [sp]
               	str	x21, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	pmull2	v0.1q, v1.2d, v2.2d
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x0, x29, #0x50
               	ldr	x8, [x0]
               	ldr	x9, [x0, #0x8]
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0xff00             // =65280
               	movk	x1, #0xddee, lsl #16
               	movk	x1, #0xbbcc, lsl #32
               	movk	x1, #0x99aa, lsl #48
               	sub	x2, x29, #0x30
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x2, [sp]
               	fmov	d16, x0
               	str	d16, [sp, #0x8]
               	fmov	d16, x1
               	str	d16, [sp, #0x10]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	pmull	v0.1q, v1.1d, v2.1d
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x0, x29, #0x30
               	ldr	x10, [x0]
               	ldr	x11, [x0, #0x8]
               	mov	x4, #0xcdef             // =52719
               	movk	x4, #0x89ab, lsl #16
               	movk	x4, #0x4567, lsl #32
               	movk	x4, #0x123, lsl #48
               	mov	x6, #0xff00             // =65280
               	movk	x6, #0xddee, lsl #16
               	movk	x6, #0xbbcc, lsl #32
               	movk	x6, #0x99aa, lsl #48
               	sub	x2, x29, #0x338
               	sub	x3, x29, #0x330
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	str	x0, [x3]
               	b	<addr>
               	lsr	x5, x6, x1
               	mov	x17, #0x1               // =1
               	and	x5, x5, x17
               	cbz	x5, <addr>
               	ldr	x5, [x2]
               	lsl	x7, x4, x1
               	eor	x5, x5, x7
               	str	x5, [x2]
               	cbz	x1, <addr>
               	ldr	x7, [x3]
               	mov	x5, #0x40               // =64
               	sub	x5, x5, x0
               	sxtw	x5, w5
               	lsr	x5, x4, x5
               	eor	x5, x7, x5
               	str	x5, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	sub	x16, x29, #0x338
               	ldr	x0, [x16]
               	cmp	x8, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x330
               	ldr	x0, [x16]
               	cmp	x9, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x8, x10
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x9, x11
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x2b8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x80
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0x1c0
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x1c8
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x1d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x2f8
               	sub	x1, x29, #0x1d8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x2f8
               	ldr	x0, [x16]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1a0
               	sub	x0, x29, #0x2d8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x60
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x60
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x138
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x138
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x140
               	ldr	x0, [x16]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x2f0
               	sub	x1, x29, #0x150
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[1]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x2f0
               	ldr	x0, [x16]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x1a0
               	sub	x0, x29, #0x2b8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0x1a0
               	sub	x1, x29, #0x110
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x118
               	sub	x1, x29, #0x110
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x118
               	ldr	x0, [x16]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x350
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
