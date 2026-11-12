
arm_neon_halfword_lanes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x10]
               	ldur	q1, [x29, #-0x10]
               	mov	x16, #0x4141            // =16705
               	dup	v2.8h, w16
               	cmeq	v1.8h, v1.8h, v2.8h
               	shrn	v1.8b, v1.8h, #0x4
               	mov	x0, v1.d[0]
               	mov	x17, #0xff000000        // =4278190080
               	movk	x17, #0xff00, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d1, [x29, #-0x10]
               	eor	v0.8b, v1.8b, v0.8b
               	mov	x0, v0.d[0]
               	mov	x17, #0x800000000000    // =140737488355328
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x1               // =1
               	movk	x16, #0x2, lsl #16
               	movk	x16, #0x3, lsl #32
               	movk	x16, #0x4, lsl #48
               	fmov	d0, x16
               	dup	v0.2d, v0.d[0]
               	umov	w0, v0.h[0]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
