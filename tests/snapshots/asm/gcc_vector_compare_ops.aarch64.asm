
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
               	sub	sp, sp, #0x150
               	sub	x0, x29, #0x150
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x130
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x110
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xf0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xe0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x1, x29, #0x40
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
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	mov	x1, #-0x1               // =-1
               	ldrsb	x3, [x2, x0]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	mov	x3, #-0x1               // =-1
               	strb	w3, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w3, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w3, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w3, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w3, [x0, #0xd]
               	strb	w1, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x2, x29, #0x150
               	sub	x4, x29, #0x140
               	mov	x0, x1
               	sub	x5, x29, #0x10
               	ldrb	w6, [x2, x0]
               	ldrb	w7, [x4, x0]
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, x3
               	b	<addr>
               	mov	x6, x1
               	strb	w6, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w5, [x4, x0]
               	cmp	w2, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x150
               	sub	x2, x29, #0x140
               	sub	x5, x29, #0x40
               	ldrb	w0, [x1]
               	ldrb	w6, [x2]
               	cmp	w0, w6
               	cset	x6, ne
               	mov	x0, #0x0                // =0
               	neg	x6, x6
               	strb	w6, [x5]
               	ldrb	w6, [x1, #0x1]
               	ldrb	w7, [x2, #0x1]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x2, #0x2]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x2, #0x3]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x2, #0x4]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x4]
               	ldrb	w6, [x1, #0x5]
               	ldrb	w7, [x2, #0x5]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x5]
               	ldrb	w6, [x1, #0x6]
               	ldrb	w7, [x2, #0x6]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x6]
               	ldrb	w6, [x1, #0x7]
               	ldrb	w7, [x2, #0x7]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x7]
               	ldrb	w6, [x1, #0x8]
               	ldrb	w7, [x2, #0x8]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x8]
               	ldrb	w6, [x1, #0x9]
               	ldrb	w7, [x2, #0x9]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0x9]
               	ldrb	w6, [x1, #0xa]
               	ldrb	w7, [x2, #0xa]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xa]
               	ldrb	w6, [x1, #0xb]
               	ldrb	w7, [x2, #0xb]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xb]
               	ldrb	w6, [x1, #0xc]
               	ldrb	w7, [x2, #0xc]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xc]
               	ldrb	w6, [x1, #0xd]
               	ldrb	w7, [x2, #0xd]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xd]
               	ldrb	w6, [x1, #0xe]
               	ldrb	w7, [x2, #0xe]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xe]
               	ldrb	w6, [x1, #0xf]
               	ldrb	w7, [x2, #0xf]
               	cmp	w6, w7
               	cset	x6, ne
               	neg	x6, x6
               	strb	w6, [x5, #0xf]
               	sub	x6, x29, #0x50
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x6]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	cmp	w5, w6
               	b.eq	<addr>
               	mov	x5, x3
               	b	<addr>
               	mov	x5, #0x0                // =0
               	strb	w5, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x3, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	ldrb	w5, [x3]
               	cmp	w0, w5
               	cset	x5, lo
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrb	w5, [x2, #0x3]
               	ldrb	w6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrb	w5, [x2, #0x4]
               	ldrb	w6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrb	w5, [x2, #0x5]
               	ldrb	w6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrb	w5, [x2, #0x6]
               	ldrb	w6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrb	w5, [x2, #0x7]
               	ldrb	w6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrb	w5, [x2, #0x8]
               	ldrb	w6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrb	w5, [x2, #0x9]
               	ldrb	w6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrb	w5, [x2, #0xa]
               	ldrb	w6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrb	w5, [x2, #0xb]
               	ldrb	w6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrb	w5, [x2, #0xc]
               	ldrb	w6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrb	w5, [x2, #0xd]
               	ldrb	w6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrb	w5, [x2, #0xe]
               	ldrb	w6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrb	w5, [x2, #0xf]
               	ldrb	w6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, lo
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x3, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	ldrb	w5, [x3]
               	cmp	w0, w5
               	cset	x5, ls
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrb	w5, [x2, #0x3]
               	ldrb	w6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrb	w5, [x2, #0x4]
               	ldrb	w6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrb	w5, [x2, #0x5]
               	ldrb	w6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrb	w5, [x2, #0x6]
               	ldrb	w6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrb	w5, [x2, #0x7]
               	ldrb	w6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrb	w5, [x2, #0x8]
               	ldrb	w6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrb	w5, [x2, #0x9]
               	ldrb	w6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrb	w5, [x2, #0xa]
               	ldrb	w6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrb	w5, [x2, #0xb]
               	ldrb	w6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrb	w5, [x2, #0xc]
               	ldrb	w6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrb	w5, [x2, #0xd]
               	ldrb	w6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrb	w5, [x2, #0xe]
               	ldrb	w6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrb	w5, [x2, #0xf]
               	ldrb	w6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, ls
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x3, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	ldrb	w5, [x3]
               	cmp	w0, w5
               	cset	x5, hi
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrb	w5, [x2, #0x3]
               	ldrb	w6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrb	w5, [x2, #0x4]
               	ldrb	w6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrb	w5, [x2, #0x5]
               	ldrb	w6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrb	w5, [x2, #0x6]
               	ldrb	w6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrb	w5, [x2, #0x7]
               	ldrb	w6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrb	w5, [x2, #0x8]
               	ldrb	w6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrb	w5, [x2, #0x9]
               	ldrb	w6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrb	w5, [x2, #0xa]
               	ldrb	w6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrb	w5, [x2, #0xb]
               	ldrb	w6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrb	w5, [x2, #0xc]
               	ldrb	w6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrb	w5, [x2, #0xd]
               	ldrb	w6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrb	w5, [x2, #0xe]
               	ldrb	w6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrb	w5, [x2, #0xf]
               	ldrb	w6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, hi
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x3, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	ldrb	w5, [x3]
               	cmp	w0, w5
               	cset	x5, hs
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrb	w5, [x2, #0x1]
               	ldrb	w6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrb	w5, [x2, #0x3]
               	ldrb	w6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrb	w5, [x2, #0x4]
               	ldrb	w6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrb	w5, [x2, #0x5]
               	ldrb	w6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrb	w5, [x2, #0x6]
               	ldrb	w6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrb	w5, [x2, #0x7]
               	ldrb	w6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrb	w5, [x2, #0x8]
               	ldrb	w6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrb	w5, [x2, #0x9]
               	ldrb	w6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrb	w5, [x2, #0xa]
               	ldrb	w6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrb	w5, [x2, #0xb]
               	ldrb	w6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrb	w5, [x2, #0xc]
               	ldrb	w6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrb	w5, [x2, #0xd]
               	ldrb	w6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrb	w5, [x2, #0xe]
               	ldrb	w6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrb	w5, [x2, #0xf]
               	ldrb	w6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, hs
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, eq
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, ne
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, ne
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, lt
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, lt
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, le
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, le
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, gt
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x4, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w3, [x4, x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	sub	x3, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	ldrsb	x5, [x3]
               	cmp	w0, w5
               	cset	x5, ge
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	ldrsb	x6, [x3, #0x1]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	ldrsb	x6, [x3, #0x2]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	ldrsb	x6, [x3, #0x3]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	ldrsb	x6, [x3, #0x4]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	ldrsb	x6, [x3, #0x5]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	ldrsb	x6, [x3, #0x6]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	ldrsb	x6, [x3, #0x7]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	ldrsb	x6, [x3, #0x8]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	ldrsb	x6, [x3, #0x9]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	ldrsb	x6, [x3, #0xa]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	ldrsb	x6, [x3, #0xb]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	ldrsb	x6, [x3, #0xc]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	ldrsb	x6, [x3, #0xd]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	ldrsb	x6, [x3, #0xe]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	ldrsb	x6, [x3, #0xf]
               	cmp	w5, w6
               	cset	x5, ge
               	neg	x5, x5
               	strb	w5, [x1, #0xf]
               	sub	x5, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
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
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, eq
               	neg	x6, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, eq
               	neg	x7, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, eq
               	neg	x8, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, eq
               	neg	x9, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, eq
               	neg	x10, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, eq
               	neg	x11, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, eq
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, lo
               	neg	x6, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, lo
               	neg	x7, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, lo
               	neg	x8, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, lo
               	neg	x9, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, lo
               	neg	x10, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, lo
               	neg	x11, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, lo
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	sub	x4, x29, #0x100
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x1, hs
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrh	w1, [x3, #0x2]
               	ldrh	w6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, hs
               	neg	x6, x1
               	ldrh	w1, [x3, #0x4]
               	ldrh	w7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, hs
               	neg	x7, x1
               	ldrh	w1, [x3, #0x6]
               	ldrh	w8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, hs
               	neg	x8, x1
               	ldrh	w1, [x3, #0x8]
               	ldrh	w9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, hs
               	neg	x9, x1
               	ldrh	w1, [x3, #0xa]
               	ldrh	w10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, hs
               	neg	x10, x1
               	ldrh	w1, [x3, #0xc]
               	ldrh	w11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, hs
               	neg	x11, x1
               	ldrh	w1, [x3, #0xe]
               	ldrh	w12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, hs
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, ne
               	neg	x6, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, ne
               	neg	x7, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, ne
               	neg	x8, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, ne
               	neg	x9, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, ne
               	neg	x10, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, ne
               	neg	x11, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, ne
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, le
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, le
               	neg	x6, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, le
               	neg	x7, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, le
               	neg	x8, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, le
               	neg	x9, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, le
               	neg	x10, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, le
               	neg	x11, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, le
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xf0
               	sub	x4, x29, #0xe0
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsh	x1, [x3, #0x2]
               	ldrsh	x6, [x4, #0x2]
               	cmp	w1, w6
               	cset	x1, gt
               	neg	x6, x1
               	ldrsh	x1, [x3, #0x4]
               	ldrsh	x7, [x4, #0x4]
               	cmp	w1, w7
               	cset	x1, gt
               	neg	x7, x1
               	ldrsh	x1, [x3, #0x6]
               	ldrsh	x8, [x4, #0x6]
               	cmp	w1, w8
               	cset	x1, gt
               	neg	x8, x1
               	ldrsh	x1, [x3, #0x8]
               	ldrsh	x9, [x4, #0x8]
               	cmp	w1, w9
               	cset	x1, gt
               	neg	x9, x1
               	ldrsh	x1, [x3, #0xa]
               	ldrsh	x10, [x4, #0xa]
               	cmp	w1, w10
               	cset	x1, gt
               	neg	x10, x1
               	ldrsh	x1, [x3, #0xc]
               	ldrsh	x11, [x4, #0xc]
               	cmp	w1, w11
               	cset	x1, gt
               	neg	x11, x1
               	ldrsh	x1, [x3, #0xe]
               	ldrsh	x12, [x4, #0xe]
               	cmp	w1, w12
               	cset	x1, gt
               	neg	x12, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	w1, [x3, #0x4]
               	ldr	w6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, lo
               	neg	x6, x1
               	ldr	w1, [x3, #0x8]
               	ldr	w7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, lo
               	neg	x7, x1
               	ldr	w1, [x3, #0xc]
               	ldr	w8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, lo
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xd0
               	sub	x4, x29, #0xc0
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	w1, [x3, #0x4]
               	ldr	w6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, eq
               	neg	x6, x1
               	ldr	w1, [x3, #0x8]
               	ldr	w7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, eq
               	neg	x7, x1
               	ldr	w1, [x3, #0xc]
               	ldr	w8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, eq
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	sub	x4, x29, #0xa0
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, lt
               	neg	x6, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, lt
               	neg	x7, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, lt
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	sub	x4, x29, #0xa0
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, ge
               	neg	x6, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, ge
               	neg	x7, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, ge
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	sub	x4, x29, #0xa0
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrsw	x1, [x3, #0x4]
               	ldrsw	x6, [x4, #0x4]
               	cmp	w1, w6
               	cset	x1, ne
               	neg	x6, x1
               	ldrsw	x1, [x3, #0x8]
               	ldrsw	x7, [x4, #0x8]
               	cmp	w1, w7
               	cset	x1, ne
               	neg	x7, x1
               	ldrsw	x1, [x3, #0xc]
               	ldrsw	x8, [x4, #0xc]
               	cmp	w1, w8
               	cset	x1, ne
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x90
               	sub	x4, x29, #0x80
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, lo
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x90
               	sub	x4, x29, #0x80
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, hi
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, hi
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x70
               	sub	x4, x29, #0x60
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, lt
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x70
               	sub	x4, x29, #0x60
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	x1, [x3, #0x8]
               	ldr	x6, [x4, #0x8]
               	cmp	x1, x6
               	cset	x1, eq
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x28
               	sub	x4, x29, #0x20
               	ldrb	w0, [x3]
               	ldrb	w1, [x4]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldrb	w1, [x3, #0x1]
               	ldrb	w6, [x4, #0x1]
               	cmp	w1, w6
               	cset	x1, lo
               	neg	x6, x1
               	ldrb	w1, [x3, #0x2]
               	ldrb	w7, [x4, #0x2]
               	cmp	w1, w7
               	cset	x1, lo
               	neg	x7, x1
               	ldrb	w1, [x3, #0x3]
               	ldrb	w8, [x4, #0x3]
               	cmp	w1, w8
               	cset	x1, lo
               	neg	x8, x1
               	ldrb	w1, [x3, #0x4]
               	ldrb	w9, [x4, #0x4]
               	cmp	w1, w9
               	cset	x1, lo
               	neg	x9, x1
               	ldrb	w1, [x3, #0x5]
               	ldrb	w10, [x4, #0x5]
               	cmp	w1, w10
               	cset	x1, lo
               	neg	x10, x1
               	ldrb	w1, [x3, #0x6]
               	ldrb	w11, [x4, #0x6]
               	cmp	w1, w11
               	cset	x1, lo
               	neg	x11, x1
               	ldrb	w1, [x3, #0x7]
               	ldrb	w12, [x4, #0x7]
               	cmp	w1, w12
               	cset	x1, lo
               	neg	x12, x1
               	sub	x1, x29, #0x18
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
               	sub	x5, x29, #0x8
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
               	sub	x1, x29, #0x18
               	sub	x3, x29, #0x8
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x1, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	sub	x3, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldr	s0, [x0]
               	str	s0, [x3, #0x8]
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, eq
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, eq
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, eq
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ne
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ne
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ne
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, mi
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, mi
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, mi
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ls
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ls
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ls
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ls
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, gt
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, gt
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, gt
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x1, ge
               	neg	x6, x1
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x1, ge
               	neg	x7, x1
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x1, ge
               	neg	x8, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	fmov	d0, #2.00000000
               	fcvt	s0, d0
               	ldr	s1, [x3]
               	fcmp	s1, s0
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x4, x1
               	ldr	s1, [x3, #0x4]
               	fcmp	s1, s0
               	cset	x1, gt
               	neg	x5, x1
               	ldr	s1, [x3, #0x8]
               	fcmp	s1, s0
               	cset	x1, gt
               	neg	x6, x1
               	ldr	s1, [x3, #0xc]
               	fcmp	s1, s0
               	cset	x1, gt
               	neg	x7, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x3, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldr	d0, [x0]
               	str	d0, [x3, #0x8]
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, eq
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, ne
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x60
               	sub	x4, x29, #0x50
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	neg	x5, x1
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x1, mi
               	neg	x6, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	cmp	w0, #0x64
               	cset	x4, hi
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
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
               	sub	x1, x29, #0x50
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	cmp	w0, #0x3
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
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
               	sub	x1, x29, #0x50
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	cmp	w0, #0xff
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
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
               	sub	x1, x29, #0x50
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x130
               	mov	x4, #-0x5               // =-5
               	sub	x1, x29, #0x40
               	ldrsb	x0, [x2]
               	cmp	w0, w4
               	cset	x5, gt
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	strb	w5, [x1]
               	ldrsb	x5, [x2, #0x1]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x1]
               	ldrsb	x5, [x2, #0x2]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x2]
               	ldrsb	x5, [x2, #0x3]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x3]
               	ldrsb	x5, [x2, #0x4]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x4]
               	ldrsb	x5, [x2, #0x5]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x5]
               	ldrsb	x5, [x2, #0x6]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x6]
               	ldrsb	x5, [x2, #0x7]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x7]
               	ldrsb	x5, [x2, #0x8]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x8]
               	ldrsb	x5, [x2, #0x9]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0x9]
               	ldrsb	x5, [x2, #0xa]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xa]
               	ldrsb	x5, [x2, #0xb]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xb]
               	ldrsb	x5, [x2, #0xc]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xc]
               	ldrsb	x5, [x2, #0xd]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xd]
               	ldrsb	x5, [x2, #0xe]
               	cmp	w5, w4
               	cset	x5, gt
               	neg	x5, x5
               	strb	w5, [x1, #0xe]
               	ldrsb	x5, [x2, #0xf]
               	cmp	w5, w4
               	cset	x4, gt
               	neg	x4, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	mov	x4, #-0x5               // =-5
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
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xb0
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x3]
               	cmp	w1, #0x0
               	cset	x1, lt
               	neg	x4, x1
               	ldrsw	x1, [x3, #0x4]
               	cmp	w1, #0x0
               	cset	x1, lt
               	neg	x5, x1
               	ldrsw	x1, [x3, #0x8]
               	cmp	w1, #0x0
               	cset	x1, lt
               	neg	x6, x1
               	ldrsw	x1, [x3, #0xc]
               	cmp	w1, #0x0
               	cset	x1, lt
               	neg	x7, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x90
               	ldr	x0, [x3]
               	cmp	x0, #0x5
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x4, x1
               	ldr	x1, [x3, #0x8]
               	cmp	x1, #0x5
               	cset	x1, ne
               	neg	x5, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	ldrb	w4, [x3, x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [x2]
               	cmp	w0, #0x64
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	strb	w4, [x1]
               	ldrb	w4, [x2, #0x1]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x1]
               	ldrb	w4, [x2, #0x2]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x2]
               	ldrb	w4, [x2, #0x3]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x3]
               	ldrb	w4, [x2, #0x4]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x4]
               	ldrb	w4, [x2, #0x5]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x5]
               	ldrb	w4, [x2, #0x6]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x6]
               	ldrb	w4, [x2, #0x7]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x7]
               	ldrb	w4, [x2, #0x8]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x8]
               	ldrb	w4, [x2, #0x9]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0x9]
               	ldrb	w4, [x2, #0xa]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xa]
               	ldrb	w4, [x2, #0xb]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xb]
               	ldrb	w4, [x2, #0xc]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xc]
               	ldrb	w4, [x2, #0xd]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xd]
               	ldrb	w4, [x2, #0xe]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xe]
               	ldrb	w4, [x2, #0xf]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	strb	w4, [x1, #0xf]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
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
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xb0
               	ldrsw	x1, [x3]
               	cmp	w1, #0x0
               	cset	x1, ge
               	neg	x4, x1
               	ldrsw	x1, [x3, #0x4]
               	cmp	w1, #0x0
               	cset	x1, ge
               	neg	x5, x1
               	ldrsw	x1, [x3, #0x8]
               	cmp	w1, #0x0
               	cset	x1, ge
               	neg	x6, x1
               	ldrsw	x1, [x3, #0xc]
               	cmp	w1, #0x0
               	cset	x1, ge
               	neg	x7, x1
               	sub	x1, x29, #0x40
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
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #-0x1               // =-1
               	str	w1, [x0]
               	str	wzr, [x0, #0x4]
               	str	w1, [x0, #0x8]
               	str	wzr, [x0, #0xc]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x5, lsl #32
               	and	x4, x3, x17
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9, lsl #32
               	and	x5, x0, x17
               	sub	x0, x29, #0x40
               	str	wzr, [x0]
               	str	w1, [x0, #0x4]
               	add	x3, x0, #0x8
               	str	wzr, [x3]
               	str	w1, [x0, #0xc]
               	ldr	x0, [x0]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x4, lsl #32
               	and	x1, x0, x17
               	ldr	x0, [x3]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8, lsl #32
               	and	x2, x0, x17
               	sub	x0, x29, #0x40
               	orr	x1, x4, x1
               	str	x1, [x0]
               	orr	x1, x5, x2
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
