
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	q1, [x1]
               	ext	v2.16b, v0.16b, v1.16b, #0x8
               	mov	x2, v2.d[0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x2, v2.d[1]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ext	v2.16b, v0.16b, v1.16b, #0x0
               	mov	x2, v2.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x2, v2.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	pmull2	v0.1q, v0.2d, v1.2d
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x1, #0x8]
               	pmull	v1.1q, v1.1d, v2.1d
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x89ab, lsl #16
               	movk	x1, #0x4567, lsl #32
               	movk	x1, #0x123, lsl #48
               	mov	x2, #0xff00             // =65280
               	movk	x2, #0xddee, lsl #16
               	movk	x2, #0xbbcc, lsl #32
               	movk	x2, #0x99aa, lsl #48
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	lsr	x3, x2, x0
               	tbz	w3, #0x0, <addr>
               	ldur	x3, [x29, #-0x10]
               	lsl	x4, x1, x0
               	eor	x3, x3, x4
               	stur	x3, [x29, #-0x10]
               	cbz	x0, <addr>
               	ldur	x3, [x29, #-0x8]
               	mov	x4, #0x40               // =64
               	sub	x4, x4, x0
               	lsr	x4, x1, x4
               	eor	x3, x3, x4
               	stur	x3, [x29, #-0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, v0.d[0]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	ldur	x1, [x29, #-0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v0.d[0]
               	mov	x1, v1.d[0]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x1, v1.d[1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
