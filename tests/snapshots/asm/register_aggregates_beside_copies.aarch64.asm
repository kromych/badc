
register_aggregates_beside_copies.aarch64:	file format elf64-littleaarch64

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

<make_w>:
               	add	x0, x0, x0, lsl #1
               	ret

<make_s>:
               	and	x1, x0, #0xff
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	orr	x0, x1, x0, lsl #32
               	ret

<make_p>:
               	neg	x1, x0
               	ret

<make_b>:
               	and	x0, x0, #0xff
               	orr	x0, x0, #0x100
               	orr	x0, x0, #0x20000
               	orr	x0, x0, #0x3000000
               	ret

<param_beside>:
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	and	x2, x0, #0xff
               	add	x0, x2, x0, lsr #32
               	sxtw	x0, w0
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ret

<results_beside>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x20]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	bl	<addr>
               	mov	x21, x0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	bl	<addr>
               	lsr	x22, x0, #32
               	and	x23, x0, #0xff
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	bl	<addr>
               	mov	x24, x0
               	mov	x25, x1
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	and	x0, x0, #0xff
               	bl	<addr>
               	and	x1, x0, #0xff
               	ubfx	x0, x0, #24, #8
               	add	x2, x21, x23
               	sxtw	x3, w22
               	add	x2, x2, x3
               	add	x2, x2, x24
               	sub	x2, x2, x25
               	add	x1, x2, x1
               	add	x0, x1, x0
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	stur	x1, [x29, #-0x20]
               	ldr	x0, [x0, #0x10]
               	lsl	x0, x0, #1
               	stur	x0, [x29, #-0x18]
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	sub	x0, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	sub	x2, x29, #0x20
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x30
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	bl	<addr>
               	cmp	x0, #0x53
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
