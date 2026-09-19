
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x900
               	sub	x0, x29, #0x900
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8f0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8e0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8c0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x890
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x880
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x870
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x860
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x850
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x840
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x830
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x820
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x810
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x468
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x460
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x450
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x1               // =-1
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
               	sub	x2, x29, #0x800
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #-0x1               // =-1
               	ldrsb	x3, [x2, x0]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x450
               	mov	x1, #0x0                // =0
               	strb	w1, [x2]
               	mov	x3, #-0x1               // =-1
               	strb	w3, [x2, #0x1]
               	strb	w1, [x2, #0x2]
               	strb	w3, [x2, #0x3]
               	strb	w1, [x2, #0x4]
               	strb	w3, [x2, #0x5]
               	strb	w1, [x2, #0x6]
               	strb	w1, [x2, #0x7]
               	strb	w1, [x2, #0x8]
               	strb	w3, [x2, #0x9]
               	strb	w1, [x2, #0xa]
               	strb	w1, [x2, #0xb]
               	strb	w1, [x2, #0xc]
               	strb	w3, [x2, #0xd]
               	strb	w1, [x2, #0xe]
               	strb	w1, [x2, #0xf]
               	sub	x0, x29, #0x7f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x900
               	sub	x5, x29, #0x8f0
               	mov	x0, x1
               	ldrb	w6, [x4, x0]
               	ldrb	w7, [x5, x0]
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, x3
               	b	<addr>
               	mov	x6, x1
               	strb	w6, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7f0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x2, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x900
               	sub	x2, x29, #0x8f0
               	sub	x4, x29, #0x450
               	ldrb	w0, [x1]
               	ldrb	w5, [x2]
               	cmp	w0, w5
               	cset	x5, ne
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x5
               	strb	w5, [x4]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x2, #0x1]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x2, #0x2]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x2, #0x3]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x3]
               	ldrb	w5, [x1, #0x4]
               	ldrb	w6, [x2, #0x4]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x4]
               	ldrb	w5, [x1, #0x5]
               	ldrb	w6, [x2, #0x5]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x5]
               	ldrb	w5, [x1, #0x6]
               	ldrb	w6, [x2, #0x6]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x6]
               	ldrb	w5, [x1, #0x7]
               	ldrb	w6, [x2, #0x7]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x7]
               	ldrb	w5, [x1, #0x8]
               	ldrb	w6, [x2, #0x8]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x8]
               	ldrb	w5, [x1, #0x9]
               	ldrb	w6, [x2, #0x9]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0x9]
               	ldrb	w5, [x1, #0xa]
               	ldrb	w6, [x2, #0xa]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xa]
               	ldrb	w5, [x1, #0xb]
               	ldrb	w6, [x2, #0xb]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xb]
               	ldrb	w5, [x1, #0xc]
               	ldrb	w6, [x2, #0xc]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xc]
               	ldrb	w5, [x1, #0xd]
               	ldrb	w6, [x2, #0xd]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xd]
               	ldrb	w5, [x1, #0xe]
               	ldrb	w6, [x2, #0xe]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xe]
               	ldrb	w5, [x1, #0xf]
               	ldrb	w6, [x2, #0xf]
               	cmp	w5, w6
               	cset	x5, ne
               	sub	x5, x0, x5
               	strb	w5, [x4, #0xf]
               	sub	x5, x29, #0x7e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x5]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x5, x29, #0x450
               	ldrb	w4, [x1, x0]
               	ldrb	w6, [x2, x0]
               	cmp	w4, w6
               	b.eq	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, #0x0                // =0
               	strb	w4, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7e0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x3, x29, #0x8f0
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	ldrb	w4, [x3]
               	cmp	w0, w4
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	ldrb	w5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	ldrb	w5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	ldrb	w5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	ldrb	w5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	ldrb	w5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	ldrb	w5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	ldrb	w5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	ldrb	w5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	ldrb	w5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	ldrb	w5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	ldrb	w5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	ldrb	w5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	ldrb	w5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	ldrb	w5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, lo
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x7d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrb	w1, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w1, w5
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7d0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x3, x29, #0x8f0
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	ldrb	w4, [x3]
               	cmp	w0, w4
               	cset	x4, ls
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	ldrb	w5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	ldrb	w5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	ldrb	w5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	ldrb	w5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	ldrb	w5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	ldrb	w5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	ldrb	w5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	ldrb	w5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	ldrb	w5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	ldrb	w5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	ldrb	w5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	ldrb	w5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	ldrb	w5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	ldrb	w5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, ls
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x7c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrb	w1, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w1, w5
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7c0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x3, x29, #0x8f0
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	ldrb	w4, [x3]
               	cmp	w0, w4
               	cset	x4, hi
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	ldrb	w5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	ldrb	w5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	ldrb	w5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	ldrb	w5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	ldrb	w5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	ldrb	w5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	ldrb	w5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	ldrb	w5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	ldrb	w5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	ldrb	w5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	ldrb	w5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	ldrb	w5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	ldrb	w5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	ldrb	w5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, hi
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x7b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrb	w1, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w1, w5
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7b0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x3, x29, #0x8f0
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	ldrb	w4, [x3]
               	cmp	w0, w4
               	cset	x4, hs
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	ldrb	w5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	ldrb	w5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	ldrb	w5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	ldrb	w5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	ldrb	w5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	ldrb	w5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	ldrb	w5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	ldrb	w5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	ldrb	w5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	ldrb	w5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	ldrb	w5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	ldrb	w5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	ldrb	w5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	ldrb	w5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, hs
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x7a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrb	w1, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w1, w5
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x7a0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, eq
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x790
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x790
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, ne
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, ne
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x780
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x780
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, lt
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, lt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x770
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x770
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, le
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, le
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x760
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x760
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, gt
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x750
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x750
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	sub	x3, x29, #0x8d0
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	ldrsb	x4, [x3]
               	cmp	w0, w4
               	cset	x4, ge
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	ldrsb	x5, [x3, #0x1]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	ldrsb	x5, [x3, #0x2]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	ldrsb	x5, [x3, #0x3]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	ldrsb	x5, [x3, #0x4]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	ldrsb	x5, [x3, #0x5]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	ldrsb	x5, [x3, #0x6]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	ldrsb	x5, [x3, #0x7]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	ldrsb	x5, [x3, #0x8]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	ldrsb	x5, [x3, #0x9]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	ldrsb	x5, [x3, #0xa]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	ldrsb	x5, [x3, #0xb]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	ldrsb	x5, [x3, #0xc]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	ldrsb	x5, [x3, #0xd]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	ldrsb	x5, [x3, #0xe]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	ldrsb	x5, [x3, #0xf]
               	cmp	w4, w5
               	cset	x4, ge
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x740
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	ldrsb	x5, [x3, x0]
               	cmp	w1, w5
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x740
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8c0
               	sub	x4, x29, #0x8b0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, eq
               	sub	x6, x0, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, eq
               	sub	x7, x0, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, eq
               	sub	x8, x0, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, eq
               	sub	x9, x0, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, eq
               	sub	x10, x0, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, eq
               	sub	x11, x0, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, eq
               	sub	x12, x0, x1
               	sub	x1, x29, #0x730
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x730
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8c0
               	sub	x4, x29, #0x8b0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, lo
               	sub	x6, x0, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, lo
               	sub	x7, x0, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, lo
               	sub	x8, x0, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, lo
               	sub	x9, x0, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, lo
               	sub	x10, x0, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, lo
               	sub	x11, x0, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, lo
               	sub	x12, x0, x1
               	sub	x1, x29, #0x720
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x720
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8c0
               	sub	x4, x29, #0x8b0
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, hs
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, hs
               	sub	x6, x0, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, hs
               	sub	x7, x0, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, hs
               	sub	x8, x0, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, hs
               	sub	x9, x0, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, hs
               	sub	x10, x0, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, hs
               	sub	x11, x0, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, hs
               	sub	x12, x0, x1
               	sub	x1, x29, #0x710
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x710
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8a0
               	sub	x4, x29, #0x890
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, ne
               	sub	x6, x0, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, ne
               	sub	x7, x0, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, ne
               	sub	x8, x0, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, ne
               	sub	x9, x0, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, ne
               	sub	x10, x0, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, ne
               	sub	x11, x0, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, ne
               	sub	x12, x0, x1
               	sub	x1, x29, #0x700
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x700
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8a0
               	sub	x4, x29, #0x890
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, le
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, le
               	sub	x6, x0, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, le
               	sub	x7, x0, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, le
               	sub	x8, x0, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, le
               	sub	x9, x0, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, le
               	sub	x10, x0, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, le
               	sub	x11, x0, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, le
               	sub	x12, x0, x1
               	sub	x1, x29, #0x6f0
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x6f0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x8a0
               	sub	x4, x29, #0x890
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, gt
               	sub	x6, x0, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, gt
               	sub	x7, x0, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, gt
               	sub	x8, x0, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, gt
               	sub	x9, x0, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, gt
               	sub	x10, x0, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, gt
               	sub	x11, x0, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, gt
               	sub	x12, x0, x1
               	sub	x1, x29, #0x6e0
               	and	x5, x5, #0xffff
               	strh	w5, [x1]
               	and	x5, x6, #0xffff
               	strh	w5, [x1, #0x2]
               	and	x5, x7, #0xffff
               	strh	w5, [x1, #0x4]
               	and	x5, x8, #0xffff
               	strh	w5, [x1, #0x6]
               	and	x5, x9, #0xffff
               	strh	w5, [x1, #0x8]
               	and	x5, x10, #0xffff
               	strh	w5, [x1, #0xa]
               	and	x5, x11, #0xffff
               	strh	w5, [x1, #0xc]
               	and	x5, x12, #0xffff
               	strh	w5, [x1, #0xe]
               	lsl	x1, x0, #1
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x6e0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x880
               	sub	x4, x29, #0x870
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	w1, [x3, #0x4]
               	ldr	w6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, lo
               	sub	x6, x0, x1
               	ldr	w1, [x3, #0x8]
               	ldr	w7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, lo
               	sub	x7, x0, x1
               	ldr	w1, [x3, #0xc]
               	ldr	w8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, lo
               	sub	x8, x0, x1
               	sub	x1, x29, #0x6d0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	cmp	w6, w1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x6d0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x880
               	sub	x4, x29, #0x870
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	w1, [x3, #0x4]
               	ldr	w6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, eq
               	sub	x6, x0, x1
               	ldr	w1, [x3, #0x8]
               	ldr	w7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, eq
               	sub	x7, x0, x1
               	ldr	w1, [x3, #0xc]
               	ldr	w8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, eq
               	sub	x8, x0, x1
               	sub	x1, x29, #0x6c0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x6c0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x860
               	sub	x4, x29, #0x850
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, lt
               	sub	x6, x0, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, lt
               	sub	x7, x0, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, lt
               	sub	x8, x0, x1
               	sub	x1, x29, #0x6b0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x6b0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x860
               	sub	x4, x29, #0x850
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, ge
               	sub	x6, x0, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, ge
               	sub	x7, x0, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, ge
               	sub	x8, x0, x1
               	sub	x1, x29, #0x6a0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x6a0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x860
               	sub	x4, x29, #0x850
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, ne
               	sub	x6, x0, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, ne
               	sub	x7, x0, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, ne
               	sub	x8, x0, x1
               	sub	x1, x29, #0x690
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x690
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x840
               	sub	x4, x29, #0x830
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, lo
               	sub	x6, x0, x1
               	sub	x1, x29, #0x680
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x680
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x840
               	sub	x4, x29, #0x830
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, hi
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, hi
               	sub	x6, x0, x1
               	sub	x1, x29, #0x670
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ls	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x670
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x820
               	sub	x4, x29, #0x810
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, lt
               	sub	x6, x0, x1
               	sub	x1, x29, #0x660
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x660
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x820
               	sub	x4, x29, #0x810
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, eq
               	sub	x6, x0, x1
               	sub	x1, x29, #0x650
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x650
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x468
               	sub	x4, x29, #0x460
               	ldrb	w0, [x3]
               	ldrb	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldrb	w1, [x3, #0x1]
               	ldrb	w6, [x4, #0x1]
               	cmp	w1, w6
               	cset	x1, lo
               	sub	x6, x0, x1
               	ldrb	w1, [x3, #0x2]
               	ldrb	w7, [x4, #0x2]
               	cmp	w1, w7
               	cset	x1, lo
               	sub	x7, x0, x1
               	ldrb	w1, [x3, #0x3]
               	ldrb	w8, [x4, #0x3]
               	cmp	w1, w8
               	cset	x1, lo
               	sub	x8, x0, x1
               	ldrb	w1, [x3, #0x4]
               	ldrb	w9, [x4, #0x4]
               	cmp	w1, w9
               	cset	x1, lo
               	sub	x9, x0, x1
               	ldrb	w1, [x3, #0x5]
               	ldrb	w10, [x4, #0x5]
               	cmp	w1, w10
               	cset	x1, lo
               	sub	x10, x0, x1
               	ldrb	w1, [x3, #0x6]
               	ldrb	w11, [x4, #0x6]
               	cmp	w1, w11
               	cset	x1, lo
               	sub	x11, x0, x1
               	ldrb	w1, [x3, #0x7]
               	ldrb	w12, [x4, #0x7]
               	cmp	w1, w12
               	cset	x1, lo
               	sub	x12, x0, x1
               	sub	x1, x29, #0x458
               	and	x5, x5, #0xff
               	strb	w5, [x1]
               	and	x5, x6, #0xff
               	strb	w5, [x1, #0x1]
               	and	x5, x7, #0xff
               	strb	w5, [x1, #0x2]
               	and	x5, x8, #0xff
               	strb	w5, [x1, #0x3]
               	and	x5, x9, #0xff
               	strb	w5, [x1, #0x4]
               	and	x5, x10, #0xff
               	strb	w5, [x1, #0x5]
               	and	x5, x11, #0xff
               	strb	w5, [x1, #0x6]
               	and	x5, x12, #0xff
               	strb	w5, [x1, #0x7]
               	sub	x5, x29, #0x448
               	ldrb	w1, [x3, x0]
               	ldrb	w6, [x4, x0]
               	cmp	w1, w6
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x458
               	sub	x3, x29, #0x448
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x448
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
               	sub	x3, x29, #0x640
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x630
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x0]
               	str	s0, [x3, #0x8]
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, eq
               	sub	x8, x0, x1
               	sub	x1, x29, #0x620
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x620
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	sub	x4, x29, #0x630
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ne
               	sub	x8, x0, x1
               	sub	x1, x29, #0x610
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x610
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	sub	x4, x29, #0x630
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, mi
               	sub	x8, x0, x1
               	sub	x1, x29, #0x600
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x600
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	sub	x4, x29, #0x630
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ls
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ls
               	sub	x8, x0, x1
               	sub	x1, x29, #0x5f0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.hi	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x5f0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	sub	x4, x29, #0x630
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, gt
               	sub	x8, x0, x1
               	sub	x1, x29, #0x5e0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x5e0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	sub	x4, x29, #0x630
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x6, x0, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x7, x0, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ge
               	sub	x8, x0, x1
               	sub	x1, x29, #0x5d0
               	str	w5, [x1]
               	str	w6, [x1, #0x4]
               	str	w7, [x1, #0x8]
               	str	w8, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x5d0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x640
               	fmov	d0, #2.00000000
               	fcvt	s0, d0
               	ldr	s1, [x3]
               	fcmp	s1, s0
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x1
               	ldr	s1, [x3, #0x4]
               	fcmp	s1, s0
               	cset	x1, gt
               	sub	x5, x0, x1
               	ldr	s1, [x3, #0x8]
               	fcmp	s1, s0
               	cset	x1, gt
               	sub	x6, x0, x1
               	ldr	s1, [x3, #0xc]
               	fcmp	s1, s0
               	cset	x1, gt
               	sub	x7, x0, x1
               	sub	x1, x29, #0x5c0
               	str	w4, [x1]
               	str	w5, [x1, #0x4]
               	str	w6, [x1, #0x8]
               	str	w7, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	s0, [x1]
               	fmov	d1, #2.00000000
               	fcvt	s1, d1
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x5c0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x448
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x5b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x5a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x0]
               	str	d0, [x3, #0x8]
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, eq
               	sub	x6, x0, x1
               	sub	x1, x29, #0x590
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x590
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x5b0
               	sub	x4, x29, #0x5a0
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, ne
               	sub	x6, x0, x1
               	sub	x1, x29, #0x580
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x580
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x5b0
               	sub	x4, x29, #0x5a0
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	sub	x5, x0, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, mi
               	sub	x6, x0, x1
               	sub	x1, x29, #0x570
               	str	x5, [x1]
               	str	x6, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x5, x2, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x570
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	cmp	w0, #0x64
               	cset	x3, hi
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	cmp	w3, #0x64
               	cset	x3, hi
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0x560
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x450
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x64
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x560
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	cmp	w0, #0x3
               	cset	x3, eq
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	cmp	w3, #0x3
               	cset	x3, eq
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0x550
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x450
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x550
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	cmp	w0, #0xff
               	cset	x3, lo
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	cmp	w3, #0xff
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0x540
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x450
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0xff
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x540
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x8e0
               	mov	x3, #-0x5               // =-5
               	sub	x1, x29, #0x450
               	ldrsb	x0, [x2]
               	cmp	w0, w3
               	cset	x4, gt
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x4
               	strb	w4, [x1]
               	ldrsb	x4, [x2, #0x1]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x1]
               	ldrsb	x4, [x2, #0x2]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x2]
               	ldrsb	x4, [x2, #0x3]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x3]
               	ldrsb	x4, [x2, #0x4]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x4]
               	ldrsb	x4, [x2, #0x5]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x5]
               	ldrsb	x4, [x2, #0x6]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x6]
               	ldrsb	x4, [x2, #0x7]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x7]
               	ldrsb	x4, [x2, #0x8]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x8]
               	ldrsb	x4, [x2, #0x9]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0x9]
               	ldrsb	x4, [x2, #0xa]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xa]
               	ldrsb	x4, [x2, #0xb]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xb]
               	ldrsb	x4, [x2, #0xc]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xc]
               	ldrsb	x4, [x2, #0xd]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xd]
               	ldrsb	x4, [x2, #0xe]
               	cmp	w4, w3
               	cset	x4, gt
               	sub	x4, x0, x4
               	strb	w4, [x1, #0xe]
               	ldrsb	x4, [x2, #0xf]
               	cmp	w4, w3
               	cset	x3, gt
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0x530
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x4, #-0x5               // =-5
               	sub	x3, x29, #0x450
               	ldrsb	x1, [x2, x0]
               	cmp	w1, w4
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x530
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x860
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x3]
               	cmp	w1, #0x0
               	cset	x1, lt
               	sub	x4, x0, x1
               	ldrsw	x1, [x3, #0x4]
               	cmp	w1, #0x0
               	cset	x1, lt
               	sub	x5, x0, x1
               	ldrsw	x1, [x3, #0x8]
               	cmp	w1, #0x0
               	cset	x1, lt
               	sub	x6, x0, x1
               	ldrsw	x1, [x3, #0xc]
               	cmp	w1, #0x0
               	cset	x1, lt
               	sub	x7, x0, x1
               	sub	x1, x29, #0x520
               	str	w4, [x1]
               	str	w5, [x1, #0x4]
               	str	w6, [x1, #0x8]
               	str	w7, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x520
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x840
               	ldr	x0, [x3]
               	cmp	x0, #0x5
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	sub	x4, x0, x1
               	ldr	x1, [x3, #0x8]
               	cmp	x1, #0x5
               	cset	x1, ne
               	sub	x5, x0, x1
               	sub	x1, x29, #0x510
               	str	x4, [x1]
               	str	x5, [x1, #0x8]
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x510
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x900
               	sub	x1, x29, #0x450
               	ldrb	w0, [x2]
               	cmp	w0, #0x64
               	cset	x3, lo
               	mov	x0, #0x0                // =0
               	sub	x3, x0, x3
               	strb	w3, [x1]
               	ldrb	w3, [x2, #0x1]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x2, #0x2]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x2, #0x3]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x3]
               	ldrb	w3, [x2, #0x4]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x4]
               	ldrb	w3, [x2, #0x5]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xa]
               	ldrb	w3, [x2, #0xb]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xb]
               	ldrb	w3, [x2, #0xc]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x2, #0xd]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x2, #0xe]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xe]
               	ldrb	w3, [x2, #0xf]
               	cmp	w3, #0x64
               	cset	x3, lo
               	sub	x3, x0, x3
               	strb	w3, [x1, #0xf]
               	sub	x3, x29, #0x500
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x450
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x64
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x500
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x860
               	ldrsw	x1, [x3]
               	cmp	w1, #0x0
               	cset	x1, ge
               	sub	x4, x0, x1
               	ldrsw	x1, [x3, #0x4]
               	cmp	w1, #0x0
               	cset	x1, ge
               	sub	x5, x0, x1
               	ldrsw	x1, [x3, #0x8]
               	cmp	w1, #0x0
               	cset	x1, ge
               	sub	x6, x0, x1
               	ldrsw	x1, [x3, #0xc]
               	cmp	w1, #0x0
               	cset	x1, ge
               	sub	x7, x0, x1
               	sub	x1, x29, #0x4f0
               	str	w4, [x1]
               	str	w5, [x1, #0x4]
               	str	w6, [x1, #0x8]
               	str	w7, [x1, #0xc]
               	lsl	x1, x0, #2
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x4f0
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x4b0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x4a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x450
               	mov	x1, #-0x1               // =-1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	str	w2, [x0, #0x4]
               	str	w1, [x0, #0x8]
               	str	w2, [x0, #0xc]
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x5, lsl #32
               	and	x5, x3, x17
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9, lsl #32
               	and	x4, x4, x17
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	add	x3, x0, #0x8
               	str	w2, [x3]
               	str	w1, [x0, #0xc]
               	ldr	x1, [x0]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x4, lsl #32
               	and	x1, x1, x17
               	ldr	x2, [x3]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8, lsl #32
               	and	x2, x2, x17
               	orr	x1, x5, x1
               	str	x1, [x0]
               	orr	x1, x4, x2
               	str	x1, [x0, #0x8]
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	cmp	w2, #0x4
               	b.ne	<addr>
               	cmp	w3, #0x3
               	b.ne	<addr>
               	cmp	w4, #0x8
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x900
               	ldp	x29, x30, [sp], #0x10
               	ret
