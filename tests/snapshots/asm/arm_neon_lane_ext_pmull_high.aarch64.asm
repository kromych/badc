
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	q0, [x29, #-0x20]
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
               	stur	q0, [x29, #-0x20]
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
               	stur	q0, [x29, #-0x20]
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
               	stur	q0, [x29, #-0x20]
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
               	stur	q0, [x29, #-0x20]
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
               	stur	q0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x1c0]
               	ldr	x0, [sp, #0x1c0]
               	ldr	q0, [x0]
               	sub	x17, x29, #0x260
               	str	q0, [x17]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x1c0]
               	ldr	x0, [sp, #0x1c0]
               	ldr	q0, [x0]
               	sub	x17, x29, #0x250
               	str	q0, [x17]
               	sub	x16, x29, #0x260
               	ldr	q0, [x16]
               	str	q0, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	sub	x16, x29, #0x260
               	ldr	q0, [x16]
               	str	q0, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x260
               	ldr	q0, [x16]
               	sub	x16, x29, #0x250
               	ldr	q1, [x16]
               	str	q0, [sp, #0x1c0]
               	str	q1, [sp, #0x1d0]
               	ldr	q1, [sp, #0x1c0]
               	ldr	q2, [sp, #0x1d0]
               	ext	v0.16b, v1.16b, v2.16b, #0x8
               	mov	v1.16b, v0.16b
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[1]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x260
               	ldr	q0, [x16]
               	sub	x16, x29, #0x250
               	ldr	q1, [x16]
               	str	q0, [sp, #0x1c0]
               	str	q1, [sp, #0x1d0]
               	ldr	q1, [sp, #0x1c0]
               	ldr	q2, [sp, #0x1d0]
               	ext	v0.16b, v1.16b, v2.16b, #0x0
               	mov	v1.16b, v0.16b
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x260
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	sub	x7, x29, #0x250
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	x16, x29, #0x20
               	str	x16, [sp, #0x1c0]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x1c8]
               	ldr	x16, [sp, #0x1c0]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x1c8]
               	ldr	q2, [x16]
               	pmull2	v0.1q, v1.2d, v2.2d
               	sub	x17, x29, #0x170
               	str	q0, [x17]
               	mov	x16, #0xcdef            // =52719
               	movk	x16, #0x89ab, lsl #16
               	movk	x16, #0x4567, lsl #32
               	movk	x16, #0x123, lsl #48
               	str	x16, [sp, #0x1c0]
               	mov	x16, #0xff00            // =65280
               	movk	x16, #0xddee, lsl #16
               	movk	x16, #0xbbcc, lsl #32
               	movk	x16, #0x99aa, lsl #48
               	str	x16, [sp, #0x1c8]
               	ldr	d1, [sp, #0x1c0]
               	ldr	d2, [sp, #0x1c8]
               	pmull	v0.1q, v1.1d, v2.1d
               	sub	x17, x29, #0x160
               	str	q0, [x17]
               	mov	x3, #0xcdef             // =52719
               	movk	x3, #0x89ab, lsl #16
               	movk	x3, #0x4567, lsl #32
               	movk	x3, #0x123, lsl #48
               	mov	x4, #0xff00             // =65280
               	movk	x4, #0xddee, lsl #16
               	movk	x4, #0xbbcc, lsl #32
               	movk	x4, #0x99aa, lsl #48
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0x68
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x2]
               	lsr	x5, x4, x0
               	tbz	w5, #0x0, <addr>
               	ldr	x5, [x1]
               	lsl	x6, x3, x0
               	eor	x5, x5, x6
               	str	x5, [x1]
               	cbz	x0, <addr>
               	ldr	x5, [x2]
               	mov	x6, #0x40               // =64
               	sub	x6, x6, x0
               	lsr	x6, x3, x6
               	eor	x5, x5, x6
               	str	x5, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x170
               	ldr	x1, [x0]
               	ldur	x2, [x29, #-0x78]
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	ldur	x2, [x29, #-0x68]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	sub	x1, x29, #0x160
               	ldr	x3, [x1]
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x260
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	sub	x7, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x70]
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x250
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	sub	x7, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	ldur	q1, [x29, #-0x70]
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	str	q1, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x260
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	sub	x7, x29, #0x80
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x70]
               	ldur	q0, [x29, #-0x70]
               	str	q0, [sp, #0x1c0]
               	ldr	q0, [sp, #0x1c0]
               	mov	x0, v0.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
