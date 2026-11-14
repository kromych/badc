
formatted_output_to_buffers_and_va_lists.aarch64:	file format elf64-littleaarch64

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

<format>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x20
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x28             // =-40
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	ldr	x2, [x29, #0x20]
               	sub	x3, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<say>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x40
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x1]
               	str	x9, [x0]
               	ldr	x9, [x1, #0x8]
               	str	x9, [x0, #0x8]
               	ldr	x9, [x1, #0x10]
               	str	x9, [x0, #0x10]
               	ldr	x9, [x1, #0x18]
               	str	x9, [x0, #0x18]
               	ldr	x9, [sp], #0x10
               	ldr	x0, [x29, #0x10]
               	sub	x1, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	ldr	x1, [x29, #0x10]
               	sub	x2, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	sub	x0, x29, #0x40
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2a               // =42
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x7a               // =122
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x23               // =35
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x5                // =5
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0xe240             // =57920
               	movk	x3, #0x1, lsl #16
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x40
               	ldurb	w3, [x29, #-0x3b]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, x0
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	fmov	d0, #3.50000000
               	fmov	d1, #4.50000000
               	mov	x5, #0x7a               // =122
               	mov	x6, #-0x5               // =-5
               	mov	x7, #0x12c              // =300
               	sub	x8, x29, #0x50
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	and	x12, x9, #0xfffffffffffff
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, x11, lsl #48
               	b	<addr>
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, #0x7fff000000000000
               	cbz	x12, <addr>
               	orr	x10, x10, #0x800000000000
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	and	x12, x12, #0xfffffffffffff
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	stur	x9, [x29, #-0x50]
               	stur	x10, [x29, #-0x48]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	ldr	q0, [x8]
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
