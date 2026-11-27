
arm_neon_lane_ext_pmull_high.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0, #0x8]
               	pmull	v0.1q, v0.1d, v1.1d
               	mov	x6, v0.d[0]
               	mov	x7, v0.d[1]
               	mov	x5, #0xcdef             // =52719
               	movk	x5, #0x89ab, lsl #16
               	movk	x5, #0x4567, lsl #32
               	movk	x5, #0x123, lsl #48
               	mov	x3, #0xff00             // =65280
               	movk	x3, #0xddee, lsl #16
               	movk	x3, #0xbbcc, lsl #32
               	movk	x3, #0x99aa, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.ge	<addr>
               	lsr	x4, x3, x1
               	tbz	w4, #0x0, <addr>
               	lsl	x4, x5, x1
               	eor	x2, x2, x4
               	cbz	x1, <addr>
               	mov	x4, #0x40               // =64
               	sub	x4, x4, x1
               	lsr	x4, x5, x4
               	eor	x0, x0, x4
               	b	<addr>
               	mov	x17, #0xa500            // =42240
               	movk	x17, #0xb45b, lsl #16
               	movk	x17, #0xa968, lsl #32
               	movk	x17, #0xb813, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x17, #0x1dd8            // =7640
               	movk	x17, #0xcc3, lsl #16
               	movk	x17, #0x11b0, lsl #32
               	movk	x17, #0x8b, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x17, #0xa500            // =42240
               	movk	x17, #0xb45b, lsl #16
               	movk	x17, #0xa968, lsl #32
               	movk	x17, #0xb813, lsl #48
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x17, #0x1dd8            // =7640
               	movk	x17, #0xcc3, lsl #16
               	movk	x17, #0x11b0, lsl #32
               	movk	x17, #0x8b, lsl #48
               	cmp	x7, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x2a               // =42
               	ret
