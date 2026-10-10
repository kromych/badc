
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
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x1               // =-1
               	sturb	w1, [x29, #-0x40]
               	sturb	w1, [x29, #-0x3f]
               	sturb	w1, [x29, #-0x3e]
               	sturb	w1, [x29, #-0x3d]
               	sturb	w1, [x29, #-0x3c]
               	sturb	w1, [x29, #-0x3b]
               	sturb	w1, [x29, #-0x3a]
               	sturb	w1, [x29, #-0x39]
               	sturb	w1, [x29, #-0x38]
               	sturb	w1, [x29, #-0x37]
               	sturb	w1, [x29, #-0x36]
               	sturb	w1, [x29, #-0x35]
               	sturb	w1, [x29, #-0x34]
               	sturb	w1, [x29, #-0x33]
               	sturb	w1, [x29, #-0x32]
               	sturb	w1, [x29, #-0x31]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	mov	x2, #-0x1               // =-1
               	ldrsb	x3, [x1, x0]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	sturb	w1, [x29, #-0x40]
               	mov	x2, #-0x1               // =-1
               	sturb	w2, [x29, #-0x3f]
               	sturb	w1, [x29, #-0x3e]
               	sturb	w2, [x29, #-0x3d]
               	sturb	w1, [x29, #-0x3c]
               	sturb	w2, [x29, #-0x3b]
               	sturb	w1, [x29, #-0x3a]
               	sturb	w1, [x29, #-0x39]
               	sturb	w1, [x29, #-0x38]
               	sturb	w2, [x29, #-0x37]
               	sturb	w1, [x29, #-0x36]
               	sturb	w1, [x29, #-0x35]
               	sturb	w1, [x29, #-0x34]
               	sturb	w2, [x29, #-0x33]
               	sturb	w1, [x29, #-0x32]
               	sturb	w1, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x3, x29, #0x150
               	sub	x4, x29, #0x140
               	mov	x0, x1
               	sub	x5, x29, #0x10
               	ldrb	w6, [x3, x0]
               	ldrb	w7, [x4, x0]
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, x2
               	b	<addr>
               	mov	x6, x1
               	strb	w6, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x50
               	sub	x1, x29, #0x10
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x6, x29, #0x140
               	sub	x3, x29, #0x40
               	ldrb	w0, [sp]
               	ldrb	w4, [sp, #0x10]
               	cmp	w0, w4
               	cset	x4, ne
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x40]
               	ldrb	w4, [sp, #0x1]
               	ldrb	w7, [sp, #0x11]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3f]
               	ldrb	w4, [sp, #0x2]
               	ldrb	w7, [sp, #0x12]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3e]
               	ldrb	w4, [sp, #0x3]
               	ldrb	w7, [sp, #0x13]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3d]
               	ldrb	w4, [sp, #0x4]
               	ldrb	w7, [sp, #0x14]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3c]
               	ldrb	w4, [sp, #0x5]
               	ldrb	w7, [sp, #0x15]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3b]
               	ldrb	w4, [sp, #0x6]
               	ldrb	w7, [sp, #0x16]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3a]
               	ldrb	w4, [sp, #0x7]
               	ldrb	w7, [sp, #0x17]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x39]
               	ldrb	w4, [sp, #0x8]
               	ldrb	w7, [sp, #0x18]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x38]
               	ldrb	w4, [sp, #0x9]
               	ldrb	w7, [sp, #0x19]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x37]
               	ldrb	w4, [sp, #0xa]
               	ldrb	w7, [sp, #0x1a]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x36]
               	ldrb	w4, [sp, #0xb]
               	ldrb	w7, [sp, #0x1b]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x35]
               	ldrb	w4, [sp, #0xc]
               	ldrb	w7, [sp, #0x1c]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x34]
               	ldrb	w4, [sp, #0xd]
               	ldrb	w7, [sp, #0x1d]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x33]
               	ldrb	w4, [sp, #0xe]
               	ldrb	w7, [sp, #0x1e]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x32]
               	ldrb	w4, [sp, #0xf]
               	ldrb	w7, [sp, #0x1f]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	sturb	w4, [x29, #-0x31]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x4]
               	ldrb	w3, [x5, x0]
               	ldrb	w4, [x6, x0]
               	cmp	w3, w4
               	b.eq	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, #0x0                // =0
               	strb	w3, [x1, x0]
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
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	ldrb	w3, [sp, #0x10]
               	cmp	w0, w3
               	cset	x3, lo
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrb	w3, [sp, #0x1]
               	ldrb	w6, [sp, #0x11]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrb	w3, [sp, #0x2]
               	ldrb	w6, [sp, #0x12]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrb	w3, [sp, #0x3]
               	ldrb	w6, [sp, #0x13]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrb	w3, [sp, #0x4]
               	ldrb	w6, [sp, #0x14]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrb	w3, [sp, #0x5]
               	ldrb	w6, [sp, #0x15]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrb	w3, [sp, #0x6]
               	ldrb	w6, [sp, #0x16]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrb	w3, [sp, #0x7]
               	ldrb	w6, [sp, #0x17]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrb	w3, [sp, #0x8]
               	ldrb	w6, [sp, #0x18]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrb	w3, [sp, #0x9]
               	ldrb	w6, [sp, #0x19]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrb	w3, [sp, #0xa]
               	ldrb	w6, [sp, #0x1a]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrb	w3, [sp, #0xb]
               	ldrb	w6, [sp, #0x1b]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrb	w3, [sp, #0xc]
               	ldrb	w6, [sp, #0x1c]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrb	w3, [sp, #0xd]
               	ldrb	w6, [sp, #0x1d]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrb	w3, [sp, #0xe]
               	ldrb	w6, [sp, #0x1e]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrb	w3, [sp, #0xf]
               	ldrb	w6, [sp, #0x1f]
               	cmp	w3, w6
               	cset	x3, lo
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrb	w1, [x4, x0]
               	ldrb	w3, [x5, x0]
               	cmp	w1, w3
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	ldrb	w3, [sp, #0x10]
               	cmp	w0, w3
               	cset	x3, ls
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrb	w3, [sp, #0x1]
               	ldrb	w6, [sp, #0x11]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrb	w3, [sp, #0x2]
               	ldrb	w6, [sp, #0x12]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrb	w3, [sp, #0x3]
               	ldrb	w6, [sp, #0x13]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrb	w3, [sp, #0x4]
               	ldrb	w6, [sp, #0x14]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrb	w3, [sp, #0x5]
               	ldrb	w6, [sp, #0x15]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrb	w3, [sp, #0x6]
               	ldrb	w6, [sp, #0x16]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrb	w3, [sp, #0x7]
               	ldrb	w6, [sp, #0x17]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrb	w3, [sp, #0x8]
               	ldrb	w6, [sp, #0x18]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrb	w3, [sp, #0x9]
               	ldrb	w6, [sp, #0x19]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrb	w3, [sp, #0xa]
               	ldrb	w6, [sp, #0x1a]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrb	w3, [sp, #0xb]
               	ldrb	w6, [sp, #0x1b]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrb	w3, [sp, #0xc]
               	ldrb	w6, [sp, #0x1c]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrb	w3, [sp, #0xd]
               	ldrb	w6, [sp, #0x1d]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrb	w3, [sp, #0xe]
               	ldrb	w6, [sp, #0x1e]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrb	w3, [sp, #0xf]
               	ldrb	w6, [sp, #0x1f]
               	cmp	w3, w6
               	cset	x3, ls
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrb	w1, [x4, x0]
               	ldrb	w3, [x5, x0]
               	cmp	w1, w3
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	ldrb	w3, [sp, #0x10]
               	cmp	w0, w3
               	cset	x3, hi
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrb	w3, [sp, #0x1]
               	ldrb	w6, [sp, #0x11]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrb	w3, [sp, #0x2]
               	ldrb	w6, [sp, #0x12]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrb	w3, [sp, #0x3]
               	ldrb	w6, [sp, #0x13]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrb	w3, [sp, #0x4]
               	ldrb	w6, [sp, #0x14]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrb	w3, [sp, #0x5]
               	ldrb	w6, [sp, #0x15]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrb	w3, [sp, #0x6]
               	ldrb	w6, [sp, #0x16]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrb	w3, [sp, #0x7]
               	ldrb	w6, [sp, #0x17]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrb	w3, [sp, #0x8]
               	ldrb	w6, [sp, #0x18]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrb	w3, [sp, #0x9]
               	ldrb	w6, [sp, #0x19]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrb	w3, [sp, #0xa]
               	ldrb	w6, [sp, #0x1a]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrb	w3, [sp, #0xb]
               	ldrb	w6, [sp, #0x1b]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrb	w3, [sp, #0xc]
               	ldrb	w6, [sp, #0x1c]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrb	w3, [sp, #0xd]
               	ldrb	w6, [sp, #0x1d]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrb	w3, [sp, #0xe]
               	ldrb	w6, [sp, #0x1e]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrb	w3, [sp, #0xf]
               	ldrb	w6, [sp, #0x1f]
               	cmp	w3, w6
               	cset	x3, hi
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrb	w1, [x4, x0]
               	ldrb	w3, [x5, x0]
               	cmp	w1, w3
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x150
               	sub	x5, x29, #0x140
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	ldrb	w3, [sp, #0x10]
               	cmp	w0, w3
               	cset	x3, hs
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrb	w3, [sp, #0x1]
               	ldrb	w6, [sp, #0x11]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrb	w3, [sp, #0x2]
               	ldrb	w6, [sp, #0x12]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrb	w3, [sp, #0x3]
               	ldrb	w6, [sp, #0x13]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrb	w3, [sp, #0x4]
               	ldrb	w6, [sp, #0x14]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrb	w3, [sp, #0x5]
               	ldrb	w6, [sp, #0x15]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrb	w3, [sp, #0x6]
               	ldrb	w6, [sp, #0x16]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrb	w3, [sp, #0x7]
               	ldrb	w6, [sp, #0x17]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrb	w3, [sp, #0x8]
               	ldrb	w6, [sp, #0x18]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrb	w3, [sp, #0x9]
               	ldrb	w6, [sp, #0x19]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrb	w3, [sp, #0xa]
               	ldrb	w6, [sp, #0x1a]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrb	w3, [sp, #0xb]
               	ldrb	w6, [sp, #0x1b]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrb	w3, [sp, #0xc]
               	ldrb	w6, [sp, #0x1c]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrb	w3, [sp, #0xd]
               	ldrb	w6, [sp, #0x1d]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrb	w3, [sp, #0xe]
               	ldrb	w6, [sp, #0x1e]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrb	w3, [sp, #0xf]
               	ldrb	w6, [sp, #0x1f]
               	cmp	w3, w6
               	cset	x3, hs
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrb	w1, [x4, x0]
               	ldrb	w3, [x5, x0]
               	cmp	w1, w3
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, eq
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, eq
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, ne
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, ne
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, lt
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, lt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, le
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, le
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, gt
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, gt
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0x130
               	sub	x5, x29, #0x120
               	sub	x1, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	ldrsb	x3, [sp, #0x30]
               	cmp	w0, w3
               	cset	x3, ge
               	mov	x0, #0x0                // =0
               	neg	x3, x3
               	sturb	w3, [x29, #-0x40]
               	ldrsb	x3, [sp, #0x21]
               	ldrsb	x6, [sp, #0x31]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3f]
               	ldrsb	x3, [sp, #0x22]
               	ldrsb	x6, [sp, #0x32]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3e]
               	ldrsb	x3, [sp, #0x23]
               	ldrsb	x6, [sp, #0x33]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3d]
               	ldrsb	x3, [sp, #0x24]
               	ldrsb	x6, [sp, #0x34]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3c]
               	ldrsb	x3, [sp, #0x25]
               	ldrsb	x6, [sp, #0x35]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3b]
               	ldrsb	x3, [sp, #0x26]
               	ldrsb	x6, [sp, #0x36]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x3a]
               	ldrsb	x3, [sp, #0x27]
               	ldrsb	x6, [sp, #0x37]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x39]
               	ldrsb	x3, [sp, #0x28]
               	ldrsb	x6, [sp, #0x38]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x38]
               	ldrsb	x3, [sp, #0x29]
               	ldrsb	x6, [sp, #0x39]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x37]
               	ldrsb	x3, [sp, #0x2a]
               	ldrsb	x6, [sp, #0x3a]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x36]
               	ldrsb	x3, [sp, #0x2b]
               	ldrsb	x6, [sp, #0x3b]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x35]
               	ldrsb	x3, [sp, #0x2c]
               	ldrsb	x6, [sp, #0x3c]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x34]
               	ldrsb	x3, [sp, #0x2d]
               	ldrsb	x6, [sp, #0x3d]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x33]
               	ldrsb	x3, [sp, #0x2e]
               	ldrsb	x6, [sp, #0x3e]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x32]
               	ldrsb	x3, [sp, #0x2f]
               	ldrsb	x6, [sp, #0x3f]
               	cmp	w3, w6
               	cset	x3, ge
               	neg	x3, x3
               	sturb	w3, [x29, #-0x31]
               	sub	x3, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldrsb	x1, [x4, x0]
               	ldrsb	x3, [x5, x0]
               	cmp	w1, w3
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldrh	w0, [sp, #0x40]
               	ldurh	w1, [x29, #-0x100]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldrh	w3, [sp, #0x42]
               	ldurh	w4, [x29, #-0xfe]
               	cmp	w3, w4
               	cset	x3, eq
               	neg	x3, x3
               	ldrh	w4, [sp, #0x44]
               	ldurh	w7, [x29, #-0xfc]
               	cmp	w4, w7
               	cset	x4, eq
               	neg	x4, x4
               	ldrh	w7, [sp, #0x46]
               	ldurh	w8, [x29, #-0xfa]
               	cmp	w7, w8
               	cset	x7, eq
               	neg	x7, x7
               	ldrh	w8, [sp, #0x48]
               	ldurh	w9, [x29, #-0xf8]
               	cmp	w8, w9
               	cset	x8, eq
               	neg	x8, x8
               	ldrh	w9, [sp, #0x4a]
               	ldurh	w10, [x29, #-0xf6]
               	cmp	w9, w10
               	cset	x9, eq
               	neg	x9, x9
               	ldrh	w10, [sp, #0x4c]
               	ldurh	w11, [x29, #-0xf4]
               	cmp	w10, w11
               	cset	x10, eq
               	neg	x10, x10
               	ldrh	w11, [sp, #0x4e]
               	ldurh	w12, [x29, #-0xf2]
               	cmp	w11, w12
               	cset	x11, eq
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	cmp	w4, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldrh	w0, [sp, #0x40]
               	ldurh	w1, [x29, #-0x100]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldrh	w3, [sp, #0x42]
               	ldurh	w4, [x29, #-0xfe]
               	cmp	w3, w4
               	cset	x3, lo
               	neg	x3, x3
               	ldrh	w4, [sp, #0x44]
               	ldurh	w7, [x29, #-0xfc]
               	cmp	w4, w7
               	cset	x4, lo
               	neg	x4, x4
               	ldrh	w7, [sp, #0x46]
               	ldurh	w8, [x29, #-0xfa]
               	cmp	w7, w8
               	cset	x7, lo
               	neg	x7, x7
               	ldrh	w8, [sp, #0x48]
               	ldurh	w9, [x29, #-0xf8]
               	cmp	w8, w9
               	cset	x8, lo
               	neg	x8, x8
               	ldrh	w9, [sp, #0x4a]
               	ldurh	w10, [x29, #-0xf6]
               	cmp	w9, w10
               	cset	x9, lo
               	neg	x9, x9
               	ldrh	w10, [sp, #0x4c]
               	ldurh	w11, [x29, #-0xf4]
               	cmp	w10, w11
               	cset	x10, lo
               	neg	x10, x10
               	ldrh	w11, [sp, #0x4e]
               	ldurh	w12, [x29, #-0xf2]
               	cmp	w11, w12
               	cset	x11, lo
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	cmp	w4, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0x110
               	sub	x6, x29, #0x100
               	ldrh	w0, [sp, #0x40]
               	ldurh	w1, [x29, #-0x100]
               	cmp	w0, w1
               	cset	x1, hs
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldrh	w3, [sp, #0x42]
               	ldurh	w4, [x29, #-0xfe]
               	cmp	w3, w4
               	cset	x3, hs
               	neg	x3, x3
               	ldrh	w4, [sp, #0x44]
               	ldurh	w7, [x29, #-0xfc]
               	cmp	w4, w7
               	cset	x4, hs
               	neg	x4, x4
               	ldrh	w7, [sp, #0x46]
               	ldurh	w8, [x29, #-0xfa]
               	cmp	w7, w8
               	cset	x7, hs
               	neg	x7, x7
               	ldrh	w8, [sp, #0x48]
               	ldurh	w9, [x29, #-0xf8]
               	cmp	w8, w9
               	cset	x8, hs
               	neg	x8, x8
               	ldrh	w9, [sp, #0x4a]
               	ldurh	w10, [x29, #-0xf6]
               	cmp	w9, w10
               	cset	x9, hs
               	neg	x9, x9
               	ldrh	w10, [sp, #0x4c]
               	ldurh	w11, [x29, #-0xf4]
               	cmp	w10, w11
               	cset	x10, hs
               	neg	x10, x10
               	ldrh	w11, [sp, #0x4e]
               	ldurh	w12, [x29, #-0xf2]
               	cmp	w11, w12
               	cset	x11, hs
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrh	w4, [x4]
               	add	x1, x6, x1
               	ldrh	w1, [x1]
               	cmp	w4, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldursh	x0, [x29, #-0xf0]
               	ldursh	x1, [x29, #-0xe0]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursh	x3, [x29, #-0xee]
               	ldursh	x4, [x29, #-0xde]
               	cmp	w3, w4
               	cset	x3, ne
               	neg	x3, x3
               	ldursh	x4, [x29, #-0xec]
               	ldursh	x7, [x29, #-0xdc]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	ldursh	x7, [x29, #-0xea]
               	ldursh	x8, [x29, #-0xda]
               	cmp	w7, w8
               	cset	x7, ne
               	neg	x7, x7
               	ldursh	x8, [x29, #-0xe8]
               	ldursh	x9, [x29, #-0xd8]
               	cmp	w8, w9
               	cset	x8, ne
               	neg	x8, x8
               	ldursh	x9, [x29, #-0xe6]
               	ldursh	x10, [x29, #-0xd6]
               	cmp	w9, w10
               	cset	x9, ne
               	neg	x9, x9
               	ldursh	x10, [x29, #-0xe4]
               	ldursh	x11, [x29, #-0xd4]
               	cmp	w10, w11
               	cset	x10, ne
               	neg	x10, x10
               	ldursh	x11, [x29, #-0xe2]
               	ldursh	x12, [x29, #-0xd2]
               	cmp	w11, w12
               	cset	x11, ne
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldursh	x0, [x29, #-0xf0]
               	ldursh	x1, [x29, #-0xe0]
               	cmp	w0, w1
               	cset	x1, le
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursh	x3, [x29, #-0xee]
               	ldursh	x4, [x29, #-0xde]
               	cmp	w3, w4
               	cset	x3, le
               	neg	x3, x3
               	ldursh	x4, [x29, #-0xec]
               	ldursh	x7, [x29, #-0xdc]
               	cmp	w4, w7
               	cset	x4, le
               	neg	x4, x4
               	ldursh	x7, [x29, #-0xea]
               	ldursh	x8, [x29, #-0xda]
               	cmp	w7, w8
               	cset	x7, le
               	neg	x7, x7
               	ldursh	x8, [x29, #-0xe8]
               	ldursh	x9, [x29, #-0xd8]
               	cmp	w8, w9
               	cset	x8, le
               	neg	x8, x8
               	ldursh	x9, [x29, #-0xe6]
               	ldursh	x10, [x29, #-0xd6]
               	cmp	w9, w10
               	cset	x9, le
               	neg	x9, x9
               	ldursh	x10, [x29, #-0xe4]
               	ldursh	x11, [x29, #-0xd4]
               	cmp	w10, w11
               	cset	x10, le
               	neg	x10, x10
               	ldursh	x11, [x29, #-0xe2]
               	ldursh	x12, [x29, #-0xd2]
               	cmp	w11, w12
               	cset	x11, le
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	cmp	w4, w1
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0xf0
               	sub	x6, x29, #0xe0
               	ldursh	x0, [x29, #-0xf0]
               	ldursh	x1, [x29, #-0xe0]
               	cmp	w0, w1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursh	x3, [x29, #-0xee]
               	ldursh	x4, [x29, #-0xde]
               	cmp	w3, w4
               	cset	x3, gt
               	neg	x3, x3
               	ldursh	x4, [x29, #-0xec]
               	ldursh	x7, [x29, #-0xdc]
               	cmp	w4, w7
               	cset	x4, gt
               	neg	x4, x4
               	ldursh	x7, [x29, #-0xea]
               	ldursh	x8, [x29, #-0xda]
               	cmp	w7, w8
               	cset	x7, gt
               	neg	x7, x7
               	ldursh	x8, [x29, #-0xe8]
               	ldursh	x9, [x29, #-0xd8]
               	cmp	w8, w9
               	cset	x8, gt
               	neg	x8, x8
               	ldursh	x9, [x29, #-0xe6]
               	ldursh	x10, [x29, #-0xd6]
               	cmp	w9, w10
               	cset	x9, gt
               	neg	x9, x9
               	ldursh	x10, [x29, #-0xe4]
               	ldursh	x11, [x29, #-0xd4]
               	cmp	w10, w11
               	cset	x10, gt
               	neg	x10, x10
               	ldursh	x11, [x29, #-0xe2]
               	ldursh	x12, [x29, #-0xd2]
               	cmp	w11, w12
               	cset	x11, gt
               	neg	x11, x11
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x40]
               	and	x1, x3, #0xffff
               	sturh	w1, [x29, #-0x3e]
               	and	x1, x4, #0xffff
               	sturh	w1, [x29, #-0x3c]
               	and	x1, x7, #0xffff
               	sturh	w1, [x29, #-0x3a]
               	and	x1, x8, #0xffff
               	sturh	w1, [x29, #-0x38]
               	and	x1, x9, #0xffff
               	sturh	w1, [x29, #-0x36]
               	and	x1, x10, #0xffff
               	sturh	w1, [x29, #-0x34]
               	and	x1, x11, #0xffff
               	sturh	w1, [x29, #-0x32]
               	lsl	x1, x0, #1
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsh	x4, [x4]
               	add	x1, x6, x1
               	ldrsh	x1, [x1]
               	cmp	w4, w1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strh	w1, [x3]
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
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	w0, [x29, #-0xd0]
               	ldur	w1, [x29, #-0xc0]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	w3, [x29, #-0xcc]
               	ldur	w4, [x29, #-0xbc]
               	cmp	w3, w4
               	cset	x3, lo
               	neg	x3, x3
               	ldur	w4, [x29, #-0xc8]
               	ldur	w7, [x29, #-0xb8]
               	cmp	w4, w7
               	cset	x4, lo
               	neg	x4, x4
               	ldur	w7, [x29, #-0xc4]
               	ldur	w8, [x29, #-0xb4]
               	cmp	w7, w8
               	cset	x7, lo
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	cmp	w4, w1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0xd0
               	sub	x6, x29, #0xc0
               	ldur	w0, [x29, #-0xd0]
               	ldur	w1, [x29, #-0xc0]
               	cmp	w0, w1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	w3, [x29, #-0xcc]
               	ldur	w4, [x29, #-0xbc]
               	cmp	w3, w4
               	cset	x3, eq
               	neg	x3, x3
               	ldur	w4, [x29, #-0xc8]
               	ldur	w7, [x29, #-0xb8]
               	cmp	w4, w7
               	cset	x4, eq
               	neg	x4, x4
               	ldur	w7, [x29, #-0xc4]
               	ldur	w8, [x29, #-0xb4]
               	cmp	w7, w8
               	cset	x7, eq
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	w4, [x4]
               	add	x1, x6, x1
               	ldr	w1, [x1]
               	cmp	w4, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0xb0
               	sub	x6, x29, #0xa0
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xa0]
               	cmp	w0, w1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursw	x3, [x29, #-0xac]
               	ldursw	x4, [x29, #-0x9c]
               	cmp	w3, w4
               	cset	x3, lt
               	neg	x3, x3
               	ldursw	x4, [x29, #-0xa8]
               	ldursw	x7, [x29, #-0x98]
               	cmp	w4, w7
               	cset	x4, lt
               	neg	x4, x4
               	ldursw	x7, [x29, #-0xa4]
               	ldursw	x8, [x29, #-0x94]
               	cmp	w7, w8
               	cset	x7, lt
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	cmp	w4, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0xb0
               	sub	x6, x29, #0xa0
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xa0]
               	cmp	w0, w1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursw	x3, [x29, #-0xac]
               	ldursw	x4, [x29, #-0x9c]
               	cmp	w3, w4
               	cset	x3, ge
               	neg	x3, x3
               	ldursw	x4, [x29, #-0xa8]
               	ldursw	x7, [x29, #-0x98]
               	cmp	w4, w7
               	cset	x4, ge
               	neg	x4, x4
               	ldursw	x7, [x29, #-0xa4]
               	ldursw	x8, [x29, #-0x94]
               	cmp	w7, w8
               	cset	x7, ge
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	cmp	w4, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0xb0
               	sub	x6, x29, #0xa0
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xa0]
               	cmp	w0, w1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldursw	x3, [x29, #-0xac]
               	ldursw	x4, [x29, #-0x9c]
               	cmp	w3, w4
               	cset	x3, ne
               	neg	x3, x3
               	ldursw	x4, [x29, #-0xa8]
               	ldursw	x7, [x29, #-0x98]
               	cmp	w4, w7
               	cset	x4, ne
               	neg	x4, x4
               	ldursw	x7, [x29, #-0xa4]
               	ldursw	x8, [x29, #-0x94]
               	cmp	w7, w8
               	cset	x7, ne
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldrsw	x4, [x4]
               	add	x1, x6, x1
               	ldrsw	x1, [x1]
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0x90
               	sub	x6, x29, #0x80
               	ldur	x0, [x29, #-0x90]
               	ldur	x1, [x29, #-0x80]
               	cmp	x0, x1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	x3, [x29, #-0x88]
               	ldur	x4, [x29, #-0x78]
               	cmp	x3, x4
               	cset	x3, lo
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	cmp	x4, x1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x5, x29, #0x90
               	sub	x6, x29, #0x80
               	ldur	x0, [x29, #-0x90]
               	ldur	x1, [x29, #-0x80]
               	cmp	x0, x1
               	cset	x1, hi
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	x3, [x29, #-0x88]
               	ldur	x4, [x29, #-0x78]
               	cmp	x3, x4
               	cset	x3, hi
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	cmp	x4, x1
               	b.ls	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x5, x29, #0x70
               	sub	x6, x29, #0x60
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x60]
               	cmp	x0, x1
               	cset	x1, lt
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	x3, [x29, #-0x68]
               	ldur	x4, [x29, #-0x58]
               	cmp	x3, x4
               	cset	x3, lt
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	cmp	x4, x1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x5, x29, #0x70
               	sub	x6, x29, #0x60
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x60]
               	cmp	x0, x1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	x3, [x29, #-0x68]
               	ldur	x4, [x29, #-0x58]
               	cmp	x3, x4
               	cset	x3, eq
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	x4, [x4]
               	add	x1, x6, x1
               	ldr	x1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x5, x29, #0x28
               	sub	x6, x29, #0x20
               	ldurb	w0, [x29, #-0x28]
               	ldurb	w1, [x29, #-0x20]
               	cmp	w0, w1
               	cset	x1, lo
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldurb	w3, [x29, #-0x27]
               	ldurb	w4, [x29, #-0x1f]
               	cmp	w3, w4
               	cset	x3, lo
               	neg	x3, x3
               	ldurb	w4, [x29, #-0x26]
               	ldurb	w7, [x29, #-0x1e]
               	cmp	w4, w7
               	cset	x4, lo
               	neg	x4, x4
               	ldurb	w7, [x29, #-0x25]
               	ldurb	w8, [x29, #-0x1d]
               	cmp	w7, w8
               	cset	x7, lo
               	neg	x7, x7
               	ldurb	w8, [x29, #-0x24]
               	ldurb	w9, [x29, #-0x1c]
               	cmp	w8, w9
               	cset	x8, lo
               	neg	x8, x8
               	ldurb	w9, [x29, #-0x23]
               	ldurb	w10, [x29, #-0x1b]
               	cmp	w9, w10
               	cset	x9, lo
               	neg	x9, x9
               	ldurb	w10, [x29, #-0x22]
               	ldurb	w11, [x29, #-0x1a]
               	cmp	w10, w11
               	cset	x10, lo
               	neg	x10, x10
               	ldurb	w11, [x29, #-0x21]
               	ldurb	w12, [x29, #-0x19]
               	cmp	w11, w12
               	cset	x11, lo
               	neg	x11, x11
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x18]
               	and	x1, x3, #0xff
               	sturb	w1, [x29, #-0x17]
               	and	x1, x4, #0xff
               	sturb	w1, [x29, #-0x16]
               	and	x1, x7, #0xff
               	sturb	w1, [x29, #-0x15]
               	and	x1, x8, #0xff
               	sturb	w1, [x29, #-0x14]
               	and	x1, x9, #0xff
               	sturb	w1, [x29, #-0x13]
               	and	x1, x10, #0xff
               	sturb	w1, [x29, #-0x12]
               	and	x1, x11, #0xff
               	sturb	w1, [x29, #-0x11]
               	sub	x3, x29, #0x8
               	ldrb	w1, [x5, x0]
               	ldrb	w4, [x6, x0]
               	cmp	w1, w4
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x3, x0]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldur	s0, [x29, #-0x8]
               	stur	s0, [x29, #-0x58]
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x5, eq
               	neg	x5, x5
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x6, eq
               	neg	x6, x6
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, eq
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w5, [x29, #-0x3c]
               	stur	w6, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x3, ne
               	neg	x3, x3
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x4, ne
               	neg	x4, x4
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, ne
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x3, mi
               	neg	x3, x3
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x4, mi
               	neg	x4, x4
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, mi
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, ls
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x3, ls
               	neg	x3, x3
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x4, ls
               	neg	x4, x4
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, ls
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.hi	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x3, gt
               	neg	x3, x3
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x4, gt
               	neg	x4, x4
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, gt
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	s0, [x29, #-0x60]
               	ldur	s1, [x29, #-0x50]
               	fcmp	s0, s1
               	cset	x1, ge
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s0, [x29, #-0x5c]
               	ldur	s1, [x29, #-0x4c]
               	fcmp	s0, s1
               	cset	x3, ge
               	neg	x3, x3
               	ldur	s0, [x29, #-0x58]
               	ldur	s1, [x29, #-0x48]
               	fcmp	s0, s1
               	cset	x4, ge
               	neg	x4, x4
               	ldur	s0, [x29, #-0x54]
               	ldur	s1, [x29, #-0x44]
               	fcmp	s0, s1
               	cset	x7, ge
               	neg	x7, x7
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w4, [x29, #-0x38]
               	stur	w7, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	s0, [x4]
               	add	x1, x6, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x4, x29, #0x60
               	fmov	d0, #2.00000000
               	fcvt	s0, d0
               	ldur	s1, [x29, #-0x60]
               	fcmp	s1, s0
               	cset	x1, gt
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	s1, [x29, #-0x5c]
               	fcmp	s1, s0
               	cset	x3, gt
               	neg	x3, x3
               	ldur	s1, [x29, #-0x58]
               	fcmp	s1, s0
               	cset	x5, gt
               	neg	x5, x5
               	ldur	s1, [x29, #-0x54]
               	fcmp	s1, s0
               	cset	x6, gt
               	neg	x6, x6
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w5, [x29, #-0x38]
               	stur	w6, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x1, x4, x1
               	ldr	s0, [x1]
               	fmov	d1, #2.00000000
               	fcvt	s1, d1
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	sub	x4, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldur	d0, [x29, #-0x8]
               	stur	d0, [x29, #-0x58]
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x50]
               	fcmp	d0, d1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x48]
               	fcmp	d0, d1
               	cset	x5, eq
               	neg	x5, x5
               	stur	x1, [x29, #-0x40]
               	stur	x5, [x29, #-0x38]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x50]
               	fcmp	d0, d1
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x48]
               	fcmp	d0, d1
               	cset	x3, ne
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	d0, [x4]
               	add	x1, x6, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x5, x29, #0x60
               	sub	x6, x29, #0x50
               	ldur	d0, [x29, #-0x60]
               	ldur	d1, [x29, #-0x50]
               	fcmp	d0, d1
               	cset	x1, mi
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	d0, [x29, #-0x58]
               	ldur	d1, [x29, #-0x48]
               	fcmp	d0, d1
               	cset	x3, mi
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x4, x5, x1
               	ldr	d0, [x4]
               	add	x1, x6, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x3, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	cmp	w0, #0x64
               	cset	x4, hi
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x40]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x39]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x38]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x37]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x36]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x35]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x34]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x33]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x32]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x64
               	cset	x4, hi
               	neg	x4, x4
               	sturb	w4, [x29, #-0x31]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldrb	w1, [x3, x0]
               	cmp	w1, #0x64
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x3, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	cmp	w0, #0x3
               	cset	x4, eq
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x40]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x39]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x38]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x37]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x36]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x35]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x34]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x33]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x32]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x3
               	cset	x4, eq
               	neg	x4, x4
               	sturb	w4, [x29, #-0x31]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldrb	w1, [x3, x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x3, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	cmp	w0, #0xff
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x40]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x39]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x38]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x37]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x36]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x35]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x34]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x33]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x32]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0xff
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x31]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldrb	w1, [x3, x0]
               	cmp	w1, #0xff
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x3, x29, #0x130
               	mov	x1, #-0x5               // =-5
               	sub	x4, x29, #0x40
               	ldrsb	x0, [sp, #0x20]
               	cmp	w0, w1
               	cset	x5, gt
               	mov	x0, #0x0                // =0
               	neg	x5, x5
               	sturb	w5, [x29, #-0x40]
               	ldrsb	x5, [sp, #0x21]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3f]
               	ldrsb	x5, [sp, #0x22]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3e]
               	ldrsb	x5, [sp, #0x23]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3d]
               	ldrsb	x5, [sp, #0x24]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3c]
               	ldrsb	x5, [sp, #0x25]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3b]
               	ldrsb	x5, [sp, #0x26]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x3a]
               	ldrsb	x5, [sp, #0x27]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x39]
               	ldrsb	x5, [sp, #0x28]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x38]
               	ldrsb	x5, [sp, #0x29]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x37]
               	ldrsb	x5, [sp, #0x2a]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x36]
               	ldrsb	x5, [sp, #0x2b]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x35]
               	ldrsb	x5, [sp, #0x2c]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x34]
               	ldrsb	x5, [sp, #0x2d]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x33]
               	ldrsb	x5, [sp, #0x2e]
               	cmp	w5, w1
               	cset	x5, gt
               	neg	x5, x5
               	sturb	w5, [x29, #-0x32]
               	ldrsb	x5, [sp, #0x2f]
               	cmp	w5, w1
               	cset	x1, gt
               	neg	x1, x1
               	sturb	w1, [x29, #-0x31]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	mov	x4, #-0x5               // =-5
               	ldrsb	x1, [x3, x0]
               	cmp	w1, w4
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0xb0
               	mov	x0, #0x0                // =0
               	ldursw	x1, [x29, #-0xb0]
               	cmp	w1, #0x0
               	cset	x1, lt
               	neg	x1, x1
               	ldursw	x3, [x29, #-0xac]
               	cmp	w3, #0x0
               	cset	x3, lt
               	neg	x3, x3
               	ldursw	x5, [x29, #-0xa8]
               	cmp	w5, #0x0
               	cset	x5, lt
               	neg	x5, x5
               	ldursw	x6, [x29, #-0xa4]
               	cmp	w6, #0x0
               	cset	x6, lt
               	neg	x6, x6
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w5, [x29, #-0x38]
               	stur	w6, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	sub	x4, x29, #0x90
               	ldur	x0, [x29, #-0x90]
               	cmp	x0, #0x5
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	neg	x1, x1
               	ldur	x3, [x29, #-0x88]
               	cmp	x3, #0x5
               	cset	x3, ne
               	neg	x3, x3
               	stur	x1, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	lsl	x1, x0, #3
               	add	x3, x2, x1
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	x1, [x3]
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
               	sub	x3, x29, #0x150
               	sub	x1, x29, #0x40
               	ldrb	w0, [sp]
               	cmp	w0, #0x64
               	cset	x4, lo
               	mov	x0, #0x0                // =0
               	neg	x4, x4
               	sturb	w4, [x29, #-0x40]
               	ldrb	w4, [sp, #0x1]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3f]
               	ldrb	w4, [sp, #0x2]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3e]
               	ldrb	w4, [sp, #0x3]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3d]
               	ldrb	w4, [sp, #0x4]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3c]
               	ldrb	w4, [sp, #0x5]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3b]
               	ldrb	w4, [sp, #0x6]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x3a]
               	ldrb	w4, [sp, #0x7]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x39]
               	ldrb	w4, [sp, #0x8]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x38]
               	ldrb	w4, [sp, #0x9]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x37]
               	ldrb	w4, [sp, #0xa]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x36]
               	ldrb	w4, [sp, #0xb]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x35]
               	ldrb	w4, [sp, #0xc]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x34]
               	ldrb	w4, [sp, #0xd]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x33]
               	ldrb	w4, [sp, #0xe]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x32]
               	ldrb	w4, [sp, #0xf]
               	cmp	w4, #0x64
               	cset	x4, lo
               	neg	x4, x4
               	sturb	w4, [x29, #-0x31]
               	sub	x4, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldrb	w1, [x3, x0]
               	cmp	w1, #0x64
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, x0]
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
               	sub	x4, x29, #0xb0
               	ldursw	x1, [x29, #-0xb0]
               	cmp	w1, #0x0
               	cset	x1, ge
               	neg	x1, x1
               	ldursw	x3, [x29, #-0xac]
               	cmp	w3, #0x0
               	cset	x3, ge
               	neg	x3, x3
               	ldursw	x5, [x29, #-0xa8]
               	cmp	w5, #0x0
               	cset	x5, ge
               	neg	x5, x5
               	ldursw	x6, [x29, #-0xa4]
               	cmp	w6, #0x0
               	cset	x6, ge
               	neg	x6, x6
               	stur	w1, [x29, #-0x40]
               	stur	w3, [x29, #-0x3c]
               	stur	w5, [x29, #-0x38]
               	stur	w6, [x29, #-0x34]
               	lsl	x1, x0, #2
               	add	x3, x2, x1
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
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
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x40]
               	stur	wzr, [x29, #-0x3c]
               	stur	w0, [x29, #-0x38]
               	stur	wzr, [x29, #-0x34]
               	ldur	x2, [x29, #-0x40]
               	ldur	x3, [x29, #-0x38]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x5, lsl #32
               	and	x4, x2, x17
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9, lsl #32
               	and	x3, x3, x17
               	sub	x2, x29, #0x40
               	stur	wzr, [x29, #-0x40]
               	stur	w0, [x29, #-0x3c]
               	add	x2, x2, #0x8
               	str	wzr, [x2]
               	stur	w0, [x29, #-0x34]
               	ldur	x0, [x29, #-0x40]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x4, lsl #32
               	and	x0, x0, x17
               	ldr	x1, [x2]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8, lsl #32
               	and	x1, x1, x17
               	orr	x0, x4, x0
               	stur	x0, [x29, #-0x40]
               	orr	x0, x3, x1
               	stur	x0, [x29, #-0x38]
               	ldur	w0, [x29, #-0x40]
               	ldur	w1, [x29, #-0x3c]
               	ldur	w2, [x29, #-0x38]
               	ldur	w3, [x29, #-0x34]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	cmp	w1, #0x4
               	b.ne	<addr>
               	cmp	w2, #0x3
               	b.ne	<addr>
               	cmp	w3, #0x8
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
