
gcc_vector_array_whole_value_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q2, [x0]
               	stur	q0, [x29, #-0x60]
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	stur	q0, [x29, #-0x60]
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	stur	q0, [x29, #-0x60]
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stur	q2, [x29, #-0x60]
               	mov	x0, #0x707070707070707  // =506381209866536711
               	stur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	stur	q1, [x29, #-0x50]
               	ldurb	w0, [x29, #-0x60]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x51]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x303030303030303  // =217020518514230019
               	stur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	stur	q0, [x29, #-0x50]
               	ldurb	w0, [x29, #-0x59]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stur	q0, [x29, #-0x40]
               	stur	q1, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	stur	q2, [x29, #-0x60]
               	add	x1, x0, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x1, x0, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	stur	q0, [x29, #-0x60]
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	stur	q0, [x29, #-0x30]
               	stur	q0, [x29, #-0x60]
               	stur	q1, [x29, #-0x50]
               	stur	q2, [x29, #-0x40]
               	stur	q2, [x29, #-0x30]
               	stur	q1, [x29, #-0x20]
               	stur	q0, [x29, #-0x10]
               	sub	x0, x29, #0x60
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stur	q0, [x29, #-0x60]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	ldrb	w1, [x1]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xf]
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
