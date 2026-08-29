
gcc_vector_compare_ops.aarch64:	file format elf64-littleaarch64

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

<same>:
               	mov	x3, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x730
               	str	x20, [sp]
               	sub	x0, x29, #0x700
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6e0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x6a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x690
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x680
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x670
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x660
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x650
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x640
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x630
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x620
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x610
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x710
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x708
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x5f0
               	mov	x0, #0x0                // =0
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	strb	w2, [x1]
               	strb	w2, [x1, #0x1]
               	strb	w2, [x1, #0x2]
               	strb	w2, [x1, #0x3]
               	strb	w2, [x1, #0x4]
               	strb	w2, [x1, #0x5]
               	strb	w2, [x1, #0x6]
               	strb	w2, [x1, #0x7]
               	strb	w2, [x1, #0x8]
               	strb	w2, [x1, #0x9]
               	strb	w2, [x1, #0xa]
               	strb	w2, [x1, #0xb]
               	strb	w2, [x1, #0xc]
               	strb	w2, [x1, #0xd]
               	strb	w2, [x1, #0xe]
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x600
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrsb	x4, [x4]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	sub	x0, x29, #0x5f0
               	strb	w2, [x0]
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	strb	w4, [x0, #0x1]
               	strb	w2, [x0, #0x2]
               	strb	w4, [x0, #0x3]
               	strb	w2, [x0, #0x4]
               	strb	w4, [x0, #0x5]
               	strb	w2, [x0, #0x6]
               	strb	w2, [x0, #0x7]
               	strb	w2, [x0, #0x8]
               	strb	w4, [x0, #0x9]
               	strb	w2, [x0, #0xa]
               	strb	w2, [x0, #0xb]
               	strb	w2, [x0, #0xc]
               	strb	w4, [x0, #0xd]
               	strb	w2, [x0, #0xe]
               	strb	w2, [x0, #0xf]
               	sub	x1, x29, #0x5d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x5, x29, #0x700
               	sub	x6, x29, #0x6f0
               	mov	x0, x2
               	b	<addr>
               	sub	x3, x29, #0x5c8
               	sxtw	x1, w0
               	add	x7, x3, x1
               	add	x3, x5, x1
               	ldrb	w3, [x3]
               	add	x8, x6, x1
               	ldrb	w8, [x8]
               	cmp	w3, w8
               	b.ne	<addr>
               	mov	x3, x4
               	strb	w3, [x7]
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x5d8
               	sub	x1, x29, #0x5c8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x6f0
               	sub	x0, x29, #0x5f0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	cset	x3, ne
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x5b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x5a8
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrb	w5, [x5]
               	add	x8, x2, x3
               	ldrb	w8, [x8]
               	cmp	w5, w8
               	b.eq	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x5b8
               	sub	x1, x29, #0x5a8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x6f0
               	sub	x0, x29, #0x5f0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	cset	x3, lo
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, lo
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x598
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x588
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrb	w5, [x5]
               	add	x8, x2, x3
               	ldrb	w8, [x8]
               	cmp	w5, w8
               	b.ge	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x598
               	sub	x1, x29, #0x588
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x6f0
               	sub	x0, x29, #0x5f0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	cset	x3, ls
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, ls
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x578
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x568
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrb	w5, [x5]
               	add	x8, x2, x3
               	ldrb	w8, [x8]
               	cmp	w5, w8
               	b.gt	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x578
               	sub	x1, x29, #0x568
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x6f0
               	sub	x0, x29, #0x5f0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	cset	x3, hi
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, hi
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x558
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x548
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrb	w5, [x5]
               	add	x8, x2, x3
               	ldrb	w8, [x8]
               	cmp	w5, w8
               	b.le	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x558
               	sub	x1, x29, #0x548
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x6f0
               	sub	x0, x29, #0x5f0
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	cset	x3, hs
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	ldrb	w5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	ldrb	w5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	ldrb	w5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	ldrb	w5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	ldrb	w5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	ldrb	w5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	ldrb	w5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	ldrb	w5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	ldrb	w5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	ldrb	w5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	ldrb	w5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, hs
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x538
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x528
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrb	w5, [x5]
               	add	x8, x2, x3
               	ldrb	w8, [x8]
               	cmp	w5, w8
               	b.lt	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x538
               	sub	x1, x29, #0x528
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, eq
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x518
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x508
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.ne	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x518
               	sub	x1, x29, #0x508
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, ne
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, ne
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x4f8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x4e8
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.eq	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4f8
               	sub	x1, x29, #0x4e8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, lt
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, lt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x4d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x4c8
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.ge	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4d8
               	sub	x1, x29, #0x4c8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, le
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, le
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x4b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x4a8
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.gt	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4b8
               	sub	x1, x29, #0x4a8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, gt
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x498
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x488
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.le	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x498
               	sub	x1, x29, #0x488
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x6d0
               	sub	x0, x29, #0x5f0
               	ldrsb	x3, [x1]
               	ldrsb	x4, [x2]
               	cmp	w3, w4
               	cset	x3, ge
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w3, w5
               	cset	x3, ge
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x478
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x4
               	b	<addr>
               	sub	x5, x29, #0x468
               	sxtw	x3, w0
               	add	x7, x5, x3
               	add	x5, x1, x3
               	ldrsb	x5, [x5]
               	add	x8, x2, x3
               	ldrsb	x8, [x8]
               	cmp	w5, w8
               	b.lt	<addr>
               	mov	x5, x6
               	strb	w5, [x7]
               	b	<addr>
               	mov	x5, x4
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x478
               	sub	x1, x29, #0x468
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6c0
               	sub	x4, x29, #0x6b0
               	sub	x0, x29, #0x5f0
               	ldrh	w1, [x3]
               	ldrh	w2, [x4]
               	cmp	w1, w2
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrh	w1, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x3, #0x4]
               	ldrh	w5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x3, #0x6]
               	ldrh	w5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x3, #0x8]
               	ldrh	w5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x3, #0xa]
               	ldrh	w5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x3, #0xc]
               	ldrh	w5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x3, #0xe]
               	ldrh	w5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, eq
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x458
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x448
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrh	w8, [x8]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w8, w1
               	b.ne	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x458
               	sub	x1, x29, #0x448
               	mov	x20, #0x10              // =16
               	mov	x2, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6c0
               	sub	x4, x29, #0x6b0
               	sub	x0, x29, #0x5f0
               	ldrh	w1, [x3]
               	ldrh	w2, [x4]
               	cmp	w1, w2
               	cset	x1, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrh	w1, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x3, #0x4]
               	ldrh	w5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x3, #0x6]
               	ldrh	w5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x3, #0x8]
               	ldrh	w5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x3, #0xa]
               	ldrh	w5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x3, #0xc]
               	ldrh	w5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x3, #0xe]
               	ldrh	w5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, lo
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x438
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x428
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrh	w8, [x8]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w8, w1
               	b.ge	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x438
               	sub	x1, x29, #0x428
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6c0
               	sub	x4, x29, #0x6b0
               	sub	x0, x29, #0x5f0
               	ldrh	w1, [x3]
               	ldrh	w2, [x4]
               	cmp	w1, w2
               	cset	x1, hs
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrh	w1, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x3, #0x4]
               	ldrh	w5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrh	w1, [x3, #0x6]
               	ldrh	w5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrh	w1, [x3, #0x8]
               	ldrh	w5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrh	w1, [x3, #0xa]
               	ldrh	w5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrh	w1, [x3, #0xc]
               	ldrh	w5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrh	w1, [x3, #0xe]
               	ldrh	w5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, hs
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x418
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x408
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrh	w8, [x8]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w8, w1
               	b.lt	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x418
               	sub	x1, x29, #0x408
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6a0
               	sub	x4, x29, #0x690
               	sub	x0, x29, #0x5f0
               	ldrsh	x1, [x3]
               	ldrsh	x2, [x4]
               	cmp	w1, w2
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, ne
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x3f8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x3e8
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrsh	x8, [x8]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w8, w1
               	b.eq	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x3f8
               	sub	x1, x29, #0x3e8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6a0
               	sub	x4, x29, #0x690
               	sub	x0, x29, #0x5f0
               	ldrsh	x1, [x3]
               	ldrsh	x2, [x4]
               	cmp	w1, w2
               	cset	x1, le
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, le
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x3d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x3c8
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrsh	x8, [x8]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w8, w1
               	b.gt	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x3d8
               	sub	x1, x29, #0x3c8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x6a0
               	sub	x4, x29, #0x690
               	sub	x0, x29, #0x5f0
               	ldrsh	x1, [x3]
               	ldrsh	x2, [x4]
               	cmp	w1, w2
               	cset	x1, gt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	strh	w1, [x0]
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x2]
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x5, [x4, #0x4]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x4]
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x5, [x4, #0x6]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x6]
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x5, [x4, #0x8]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0x8]
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x5, [x4, #0xa]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xa]
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x5, [x4, #0xc]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xc]
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x5, [x4, #0xe]
               	cmp	w1, w5
               	cset	x1, gt
               	sub	x1, x2, x1
               	strh	w1, [x0, #0xe]
               	sub	x1, x29, #0x3b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x3a8
               	sxtw	x5, w0
               	lsl	x1, x5, #1
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldrsh	x8, [x8]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w8, w1
               	b.le	<addr>
               	mov	x1, x6
               	strh	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x5, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x3b8
               	sub	x1, x29, #0x3a8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x680
               	sub	x5, x29, #0x670
               	sub	x0, x29, #0x5f0
               	ldr	w1, [x4]
               	ldr	w2, [x5]
               	cmp	w1, w2
               	cset	x1, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	w1, [x4, #0x4]
               	ldr	w3, [x5, #0x4]
               	cmp	w1, w3
               	cset	x1, lo
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	w1, [x4, #0x8]
               	ldr	w3, [x5, #0x8]
               	cmp	w1, w3
               	cset	x1, lo
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	w1, [x4, #0xc]
               	ldr	w3, [x5, #0xc]
               	cmp	w1, w3
               	cset	x1, lo
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x398
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x388
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	w8, [x8]
               	add	x1, x5, x1
               	ldr	w1, [x1]
               	cmp	w8, w1
               	b.hs	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x398
               	sub	x1, x29, #0x388
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x680
               	sub	x5, x29, #0x670
               	sub	x0, x29, #0x5f0
               	ldr	w1, [x4]
               	ldr	w2, [x5]
               	cmp	w1, w2
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	w1, [x4, #0x4]
               	ldr	w3, [x5, #0x4]
               	cmp	w1, w3
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	w1, [x4, #0x8]
               	ldr	w3, [x5, #0x8]
               	cmp	w1, w3
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	w1, [x4, #0xc]
               	ldr	w3, [x5, #0xc]
               	cmp	w1, w3
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x378
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x368
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	w8, [x8]
               	add	x1, x5, x1
               	ldr	w1, [x1]
               	cmp	w8, w1
               	b.ne	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x378
               	sub	x1, x29, #0x368
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x660
               	sub	x5, x29, #0x650
               	sub	x0, x29, #0x5f0
               	ldrsw	x1, [x4]
               	ldrsw	x2, [x5]
               	cmp	w1, w2
               	cset	x1, lt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldrsw	x1, [x4, #0x4]
               	ldrsw	x3, [x5, #0x4]
               	cmp	w1, w3
               	cset	x1, lt
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x4, #0x8]
               	ldrsw	x3, [x5, #0x8]
               	cmp	w1, w3
               	cset	x1, lt
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x4, #0xc]
               	ldrsw	x3, [x5, #0xc]
               	cmp	w1, w3
               	cset	x1, lt
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x358
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x348
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldrsw	x8, [x8]
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	cmp	w8, w1
               	b.ge	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x348
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x660
               	sub	x5, x29, #0x650
               	sub	x0, x29, #0x5f0
               	ldrsw	x1, [x4]
               	ldrsw	x2, [x5]
               	cmp	w1, w2
               	cset	x1, ge
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldrsw	x1, [x4, #0x4]
               	ldrsw	x3, [x5, #0x4]
               	cmp	w1, w3
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x4, #0x8]
               	ldrsw	x3, [x5, #0x8]
               	cmp	w1, w3
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x4, #0xc]
               	ldrsw	x3, [x5, #0xc]
               	cmp	w1, w3
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x338
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x328
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldrsw	x8, [x8]
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	cmp	w8, w1
               	b.lt	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x338
               	sub	x1, x29, #0x328
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x660
               	sub	x5, x29, #0x650
               	sub	x0, x29, #0x5f0
               	ldrsw	x1, [x4]
               	ldrsw	x2, [x5]
               	cmp	w1, w2
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldrsw	x1, [x4, #0x4]
               	ldrsw	x3, [x5, #0x4]
               	cmp	w1, w3
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldrsw	x1, [x4, #0x8]
               	ldrsw	x3, [x5, #0x8]
               	cmp	w1, w3
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldrsw	x1, [x4, #0xc]
               	ldrsw	x3, [x5, #0xc]
               	cmp	w1, w3
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x318
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x308
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldrsw	x8, [x8]
               	add	x1, x5, x1
               	ldrsw	x1, [x1]
               	cmp	w8, w1
               	b.eq	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x308
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x640
               	sub	x5, x29, #0x630
               	sub	x0, x29, #0x5f0
               	ldr	x1, [x4]
               	ldr	x2, [x5]
               	cmp	x1, x2
               	cset	x1, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	x1, [x4, #0x8]
               	ldr	x3, [x5, #0x8]
               	cmp	x1, x3
               	cset	x1, lo
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2f8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x2e8
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x8, x1
               	b.hs	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x2f8
               	sub	x1, x29, #0x2e8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x640
               	sub	x5, x29, #0x630
               	sub	x0, x29, #0x5f0
               	ldr	x1, [x4]
               	ldr	x2, [x5]
               	cmp	x1, x2
               	cset	x1, hi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	x1, [x4, #0x8]
               	ldr	x3, [x5, #0x8]
               	cmp	x1, x3
               	cset	x1, hi
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2d8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x2c8
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x8, x1
               	b.ls	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x2d8
               	sub	x1, x29, #0x2c8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x620
               	sub	x5, x29, #0x610
               	sub	x0, x29, #0x5f0
               	ldr	x1, [x4]
               	ldr	x2, [x5]
               	cmp	x1, x2
               	cset	x1, lt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	x1, [x4, #0x8]
               	ldr	x3, [x5, #0x8]
               	cmp	x1, x3
               	cset	x1, lt
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x2a8
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x8, x1
               	b.ge	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x2b8
               	sub	x1, x29, #0x2a8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x620
               	sub	x5, x29, #0x610
               	sub	x0, x29, #0x5f0
               	ldr	x1, [x4]
               	ldr	x2, [x5]
               	cmp	x1, x2
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	x1, [x4, #0x8]
               	ldr	x3, [x5, #0x8]
               	cmp	x1, x3
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x298
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x288
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	x8, [x8]
               	add	x1, x5, x1
               	ldr	x1, [x1]
               	cmp	x8, x1
               	b.ne	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0x288
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x710
               	sub	x5, x29, #0x708
               	sub	x0, x29, #0x5e8
               	ldrb	w1, [x4]
               	ldrb	w2, [x5]
               	cmp	w1, w2
               	cset	x1, lo
               	mov	x3, #0x0                // =0
               	sub	x1, x3, x1
               	strb	w1, [x0]
               	ldrb	w1, [x4, #0x1]
               	ldrb	w2, [x5, #0x1]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x4, #0x2]
               	ldrb	w2, [x5, #0x2]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x4, #0x3]
               	ldrb	w2, [x5, #0x3]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x4, #0x4]
               	ldrb	w2, [x5, #0x4]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x4, #0x5]
               	ldrb	w2, [x5, #0x5]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x4, #0x6]
               	ldrb	w2, [x5, #0x6]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x4, #0x7]
               	ldrb	w2, [x5, #0x7]
               	cmp	w1, w2
               	cset	x1, lo
               	sub	x1, x3, x1
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x278
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x3
               	b	<addr>
               	sub	x2, x29, #0x270
               	sxtw	x1, w0
               	add	x7, x2, x1
               	add	x2, x4, x1
               	ldrb	w2, [x2]
               	add	x8, x5, x1
               	ldrb	w8, [x8]
               	cmp	w2, w8
               	b.ge	<addr>
               	mov	x2, x6
               	strb	w2, [x7]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x278
               	sub	x1, x29, #0x270
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5e8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x3, x29, #0x610
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	sub	x5, x29, #0x600
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x5]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x5
               	ldr	s0, [x0]
               	str	s0, [x3, #0x8]
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x3]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x268
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x258
               	sxtw	x4, w0
               	lsl	x1, x4, #2
               	add	x7, x7, x1
               	add	x8, x3, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x4, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x268
               	sub	x1, x29, #0x258
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x4]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x248
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x238
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x248
               	sub	x1, x29, #0x238
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x4]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, mi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x228
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x218
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.pl	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x228
               	sub	x1, x29, #0x218
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x4]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, ls
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x208
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x1f8
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.hi	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x208
               	sub	x1, x29, #0x1f8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x4]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, gt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1e8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x1d8
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1e8
               	sub	x1, x29, #0x1d8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	s0, [x4]
               	ldr	s1, [x5]
               	fcmp	s0, s1
               	cset	x1, ge
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	w1, [x0]
               	ldr	s0, [x4, #0x4]
               	ldr	s1, [x5, #0x4]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0x4]
               	ldr	s0, [x4, #0x8]
               	ldr	s1, [x5, #0x8]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0x8]
               	ldr	s0, [x4, #0xc]
               	ldr	s1, [x5, #0xc]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x1, x2, x1
               	str	w1, [x0, #0xc]
               	sub	x1, x29, #0x1c8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x1b8
               	sxtw	x3, w0
               	lsl	x1, x3, #2
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	s0, [x8]
               	add	x1, x5, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.lt	<addr>
               	mov	x1, x6
               	str	w1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0x1b8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x25               // =37
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	mov	x5, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x5
               	fcvt	s0, d16
               	sub	x0, x29, #0x5f0
               	ldr	s1, [x4]
               	fcmp	s1, s0
               	cset	x2, gt
               	mov	x1, #0x0                // =0
               	sub	x2, x1, x2
               	str	w2, [x0]
               	ldr	s1, [x4, #0x4]
               	fcmp	s1, s0
               	cset	x2, gt
               	sub	x2, x1, x2
               	str	w2, [x0, #0x4]
               	ldr	s1, [x4, #0x8]
               	fcmp	s1, s0
               	cset	x2, gt
               	sub	x2, x1, x2
               	str	w2, [x0, #0x8]
               	ldr	s1, [x4, #0xc]
               	fcmp	s1, s0
               	cset	x2, gt
               	sub	x2, x1, x2
               	str	w2, [x0, #0xc]
               	sub	x2, x29, #0x1a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x1
               	b	<addr>
               	sub	x7, x29, #0x198
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x7, x7, x3
               	add	x3, x4, x3
               	ldr	s1, [x3]
               	fcmp	s1, s0
               	b.le	<addr>
               	mov	x3, x6
               	str	w3, [x7]
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x1a8
               	sub	x1, x29, #0x198
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x26               // =38
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5e8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x4, x29, #0x610
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x4
               	sub	x5, x29, #0x600
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x5]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x5
               	ldr	d0, [x0]
               	str	d0, [x4, #0x8]
               	sub	x0, x29, #0x5f0
               	ldr	d0, [x4]
               	ldr	d1, [x5]
               	fcmp	d0, d1
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	d0, [x4, #0x8]
               	ldr	d1, [x5, #0x8]
               	fcmp	d0, d1
               	cset	x1, eq
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x188
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x178
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	d0, [x8]
               	add	x1, x5, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x188
               	sub	x1, x29, #0x178
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	d0, [x4]
               	ldr	d1, [x5]
               	fcmp	d0, d1
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	d0, [x4, #0x8]
               	ldr	d1, [x5, #0x8]
               	fcmp	d0, d1
               	cset	x1, ne
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x168
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x158
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	d0, [x8]
               	add	x1, x5, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x168
               	sub	x1, x29, #0x158
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x610
               	sub	x5, x29, #0x600
               	sub	x0, x29, #0x5f0
               	ldr	d0, [x4]
               	ldr	d1, [x5]
               	fcmp	d0, d1
               	cset	x1, mi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x1
               	str	x1, [x0]
               	ldr	d0, [x4, #0x8]
               	ldr	d1, [x5, #0x8]
               	fcmp	d0, d1
               	cset	x1, mi
               	sub	x1, x2, x1
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x7, x29, #0x138
               	sxtw	x3, w0
               	lsl	x1, x3, #3
               	add	x7, x7, x1
               	add	x8, x4, x1
               	ldr	d0, [x8]
               	add	x1, x5, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x1, x6
               	str	x1, [x7]
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x148
               	sub	x1, x29, #0x138
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x0, x29, #0x5f0
               	ldrb	w2, [x1]
               	cmp	w2, #0x64
               	cset	x3, hi
               	mov	x2, #0x0                // =0
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x128
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0x118
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	cmp	w4, #0x64
               	b.le	<addr>
               	mov	x4, x5
               	strb	w4, [x6]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x128
               	sub	x1, x29, #0x118
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x0, x29, #0x5f0
               	ldrb	w2, [x1]
               	cmp	w2, #0x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x108
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0xf8
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	cmp	w4, #0x3
               	b.ne	<addr>
               	mov	x4, x5
               	strb	w4, [x6]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x108
               	sub	x1, x29, #0xf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x0, x29, #0x5f0
               	ldrb	w2, [x1]
               	cmp	w2, #0xff
               	cset	x3, lo
               	mov	x2, #0x0                // =0
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0xd8
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	cmp	w4, #0xff
               	b.ge	<addr>
               	mov	x4, x5
               	strb	w4, [x6]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xe8
               	sub	x1, x29, #0xd8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x6e0
               	mov	x3, #0xfffb             // =65531
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	sub	x0, x29, #0x5f0
               	ldrsb	x2, [x1]
               	cmp	w2, w3
               	cset	x4, gt
               	mov	x2, #0x0                // =0
               	sub	x4, x2, x4
               	strb	w4, [x0]
               	ldrsb	x4, [x1, #0x1]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x1]
               	ldrsb	x4, [x1, #0x2]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x2]
               	ldrsb	x4, [x1, #0x3]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x3]
               	ldrsb	x4, [x1, #0x4]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x4]
               	ldrsb	x4, [x1, #0x5]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x5]
               	ldrsb	x4, [x1, #0x6]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x6]
               	ldrsb	x4, [x1, #0x7]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x7]
               	ldrsb	x4, [x1, #0x8]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x8]
               	ldrsb	x4, [x1, #0x9]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0x9]
               	ldrsb	x4, [x1, #0xa]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0xa]
               	ldrsb	x4, [x1, #0xb]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0xb]
               	ldrsb	x4, [x1, #0xc]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0xc]
               	ldrsb	x4, [x1, #0xd]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0xd]
               	ldrsb	x4, [x1, #0xe]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x2, x4
               	strb	w4, [x0, #0xe]
               	ldrsb	x4, [x1, #0xf]
               	cmp	w4, w3
               	cset	x3, gt
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0xc8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x5, #0xfffb             // =65531
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x6, #0xffff             // =65535
               	movk	x6, #0xffff, lsl #16
               	movk	x6, #0xffff, lsl #32
               	movk	x6, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0xb8
               	sxtw	x3, w0
               	add	x7, x4, x3
               	add	x4, x1, x3
               	ldrsb	x4, [x4]
               	cmp	w4, w5
               	b.le	<addr>
               	mov	x4, x6
               	strb	w4, [x7]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0xb8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x660
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x5f0
               	ldrsw	x2, [x4]
               	cmp	w2, #0x0
               	cset	x2, lt
               	sub	x2, x1, x2
               	str	w2, [x0]
               	ldrsw	x2, [x4, #0x4]
               	cmp	w2, #0x0
               	cset	x2, lt
               	sub	x2, x1, x2
               	str	w2, [x0, #0x4]
               	ldrsw	x2, [x4, #0x8]
               	cmp	w2, #0x0
               	cset	x2, lt
               	sub	x2, x1, x2
               	str	w2, [x0, #0x8]
               	ldrsw	x2, [x4, #0xc]
               	cmp	w2, #0x0
               	cset	x2, lt
               	sub	x2, x1, x2
               	str	w2, [x0, #0xc]
               	sub	x2, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x1
               	b	<addr>
               	sub	x6, x29, #0x98
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x6, x6, x3
               	add	x3, x4, x3
               	ldrsw	x3, [x3]
               	cmp	w3, #0x0
               	b.ge	<addr>
               	mov	x3, x5
               	str	w3, [x6]
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xa8
               	sub	x1, x29, #0x98
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x640
               	sub	x0, x29, #0x5f0
               	ldr	x1, [x4]
               	cmp	x1, #0x5
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	sub	x2, x1, x2
               	str	x2, [x0]
               	ldr	x2, [x4, #0x8]
               	cmp	x2, #0x5
               	cset	x2, ne
               	sub	x2, x1, x2
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x88
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x1
               	b	<addr>
               	sub	x6, x29, #0x78
               	sxtw	x2, w0
               	lsl	x3, x2, #3
               	add	x6, x6, x3
               	add	x3, x4, x3
               	ldr	x3, [x3]
               	cmp	x3, #0x5
               	b.eq	<addr>
               	mov	x3, x5
               	str	x3, [x6]
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x78
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2f               // =47
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x700
               	sub	x0, x29, #0x5f0
               	ldrb	w2, [x1]
               	cmp	w2, #0x64
               	cset	x3, lo
               	mov	x2, #0x0                // =0
               	sub	x3, x2, x3
               	strb	w3, [x0]
               	ldrb	w3, [x1, #0x1]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x1, #0x2]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x1, #0x3]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x1, #0x4]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x1, #0x5]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x1, #0x6]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x1, #0x7]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x1, #0x8]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x1, #0x9]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x1, #0xa]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x1, #0xb]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x1, #0xc]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x1, #0xd]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xe]
               	ldrb	w3, [x1, #0xf]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x2, x3
               	strb	w3, [x0, #0xf]
               	sub	x3, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x2
               	b	<addr>
               	sub	x4, x29, #0x58
               	sxtw	x3, w0
               	add	x6, x4, x3
               	add	x4, x1, x3
               	ldrb	w4, [x4]
               	cmp	w4, #0x64
               	b.ge	<addr>
               	mov	x4, x5
               	strb	w4, [x6]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x68
               	sub	x1, x29, #0x58
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x30               // =48
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	sub	x4, x29, #0x660
               	sub	x0, x29, #0x5f0
               	ldrsw	x2, [x4]
               	cmp	w2, #0x0
               	cset	x2, ge
               	sub	x2, x1, x2
               	str	w2, [x0]
               	ldrsw	x2, [x4, #0x4]
               	cmp	w2, #0x0
               	cset	x2, ge
               	sub	x2, x1, x2
               	str	w2, [x0, #0x4]
               	ldrsw	x2, [x4, #0x8]
               	cmp	w2, #0x0
               	cset	x2, ge
               	sub	x2, x1, x2
               	str	w2, [x0, #0x8]
               	ldrsw	x2, [x4, #0xc]
               	cmp	w2, #0x0
               	cset	x2, ge
               	sub	x2, x1, x2
               	str	w2, [x0, #0xc]
               	sub	x2, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, x1
               	b	<addr>
               	sub	x6, x29, #0x38
               	sxtw	x2, w0
               	lsl	x3, x2, #2
               	add	x6, x6, x3
               	add	x3, x4, x3
               	ldrsw	x3, [x3]
               	cmp	w3, #0x0
               	b.lt	<addr>
               	mov	x3, x5
               	str	w3, [x6]
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x48
               	sub	x1, x29, #0x38
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x31               // =49
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x5f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x1, x2
               	mov	x1, x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	w3, [x0]
               	str	w2, [x0, #0x4]
               	str	w3, [x0, #0x8]
               	str	w2, [x0, #0xc]
               	sub	x1, x29, #0x600
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, x1
               	ldr	x6, [x1]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x5, lsl #32
               	and	x7, x6, x17
               	ldr	x5, [x1, #0x8]
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9, lsl #32
               	and	x8, x5, x17
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	add	x6, x0, #0x8
               	str	w2, [x6]
               	str	w3, [x0, #0xc]
               	ldr	x9, [x0]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x4, lsl #32
               	and	x9, x9, x17
               	ldr	x5, [x6]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8, lsl #32
               	and	x5, x5, x17
               	orr	x6, x7, x9
               	str	x6, [x0]
               	orr	x3, x8, x5
               	str	x3, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldrsw	x0, [x1]
               	cmp	w0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	cmp	w3, #0x4
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x33               // =51
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x730
               	ldp	x29, x30, [sp], #0x10
               	ret
