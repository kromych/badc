
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
               	sub	sp, sp, #0x40
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q3, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q4, [x16]
               	mov	x0, v3.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v3.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ext	v0.16b, v3.16b, v4.16b, #0x8
               	mov	x0, v0.d[0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ext	v0.16b, v3.16b, v4.16b, #0x0
               	mov	x0, v0.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	pmull2	v0.1q, v3.2d, v4.2d
               	stur	q0, [x29, #-0x40]
               	mov	x16, #0xcdef            // =52719
               	movk	x16, #0x89ab, lsl #16
               	movk	x16, #0x4567, lsl #32
               	movk	x16, #0x123, lsl #48
               	str	x16, [sp, #0x20]
               	mov	x16, #0xff00            // =65280
               	movk	x16, #0xddee, lsl #16
               	movk	x16, #0xbbcc, lsl #32
               	movk	x16, #0x99aa, lsl #48
               	str	x16, [sp, #0x28]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	pmull	v0.1q, v1.1d, v2.1d
               	stur	q0, [x29, #-0x30]
               	mov	x3, #0xcdef             // =52719
               	movk	x3, #0x89ab, lsl #16
               	movk	x3, #0x4567, lsl #32
               	movk	x3, #0x123, lsl #48
               	mov	x4, #0xff00             // =65280
               	movk	x4, #0xddee, lsl #16
               	movk	x4, #0xbbcc, lsl #32
               	movk	x4, #0x99aa, lsl #48
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
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
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldur	x2, [x29, #-0x10]
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	ldur	x2, [x29, #-0x8]
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	sub	x1, x29, #0x30
               	ldr	x3, [x1]
               	cmp	x2, x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v3.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v3.d[1]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v4.d[0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v4.d[1]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xddee, lsl #16
               	movk	x17, #0xbbcc, lsl #32
               	movk	x17, #0x99aa, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v3.d[0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	movk	x17, #0xface, lsl #32
               	movk	x17, #0xf00d, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
