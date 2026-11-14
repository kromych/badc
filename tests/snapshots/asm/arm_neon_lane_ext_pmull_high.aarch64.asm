
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
               	ldr	d0, [x0, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0, #0x8]
               	pmull	v0.1q, v0.1d, v1.1d
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
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.ge	<addr>
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
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0xa500            // =42240
               	movk	x17, #0xb45b, lsl #16
               	movk	x17, #0xa968, lsl #32
               	movk	x17, #0xb813, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x1dd8            // =7640
               	movk	x17, #0xcc3, lsl #16
               	movk	x17, #0x11b0, lsl #32
               	movk	x17, #0x8b, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v0.d[0]
               	mov	x17, #0xa500            // =42240
               	movk	x17, #0xb45b, lsl #16
               	movk	x17, #0xa968, lsl #32
               	movk	x17, #0xb813, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #0x1dd8            // =7640
               	movk	x17, #0xcc3, lsl #16
               	movk	x17, #0x11b0, lsl #32
               	movk	x17, #0x8b, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
