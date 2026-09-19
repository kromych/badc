
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
               	cmp	w0, w2
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldrb	w5, [x3, x1]
               	ldrb	w1, [x4, x1]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xbd0
               	sub	x0, x29, #0xbd0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xbc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xbb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xba0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb00
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xaf0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xae0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x740
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x738
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x730
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
               	sub	x2, x29, #0xad0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, #-0x1               // =-1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sxtw	x1, w0
               	ldrsb	x1, [x2, x1]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x730
               	mov	x2, #0x0                // =0
               	strb	w2, [x0]
               	mov	x7, #-0x1               // =-1
               	strb	w7, [x0, #0x1]
               	strb	w2, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w2, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w2, [x0, #0x6]
               	strb	w2, [x0, #0x7]
               	strb	w2, [x0, #0x8]
               	strb	w7, [x0, #0x9]
               	strb	w2, [x0, #0xa]
               	strb	w2, [x0, #0xb]
               	strb	w2, [x0, #0xc]
               	strb	w7, [x0, #0xd]
               	strb	w2, [x0, #0xe]
               	strb	w2, [x0, #0xf]
               	sub	x1, x29, #0xac0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0xbd0
               	sub	x5, x29, #0xbc0
               	mov	x0, x2
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x600
               	sxtw	x1, w0
               	ldrb	w3, [x4, x1]
               	ldrb	w8, [x5, x1]
               	cmp	w3, w8
               	b.ne	<addr>
               	mov	x3, x7
               	b	<addr>
               	mov	x3, x2
               	strb	w3, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xac0
               	sub	x1, x29, #0x600
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbd0
               	sub	x3, x29, #0xbc0
               	sub	x0, x29, #0x730
               	ldrb	w1, [x2]
               	ldrb	w4, [x3]
               	cmp	w1, w4
               	cset	x1, ne
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrb	w1, [x2, #0x1]
               	ldrb	w4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x2, #0x2]
               	ldrb	w4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x2, #0x3]
               	ldrb	w4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x2, #0x4]
               	ldrb	w4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x2, #0x5]
               	ldrb	w4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x2, #0x6]
               	ldrb	w4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x2, #0x7]
               	ldrb	w4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x2, #0x8]
               	ldrb	w4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x2, #0x9]
               	ldrb	w4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x2, #0xa]
               	ldrb	w4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x2, #0xb]
               	ldrb	w4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x2, #0xc]
               	ldrb	w4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x2, #0xd]
               	ldrb	w4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x2, #0xe]
               	ldrb	w4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x2, #0xf]
               	ldrb	w4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xab0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x5e0
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	ldrb	w7, [x3, x1]
               	cmp	w4, w7
               	b.eq	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xab0
               	sub	x1, x29, #0x5e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbd0
               	sub	x3, x29, #0xbc0
               	sub	x0, x29, #0x730
               	ldrb	w1, [x2]
               	ldrb	w4, [x3]
               	cmp	w1, w4
               	cset	x1, lo
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrb	w1, [x2, #0x1]
               	ldrb	w4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x2, #0x2]
               	ldrb	w4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x2, #0x3]
               	ldrb	w4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x2, #0x4]
               	ldrb	w4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x2, #0x5]
               	ldrb	w4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x2, #0x6]
               	ldrb	w4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x2, #0x7]
               	ldrb	w4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x2, #0x8]
               	ldrb	w4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x2, #0x9]
               	ldrb	w4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x2, #0xa]
               	ldrb	w4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x2, #0xb]
               	ldrb	w4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x2, #0xc]
               	ldrb	w4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x2, #0xd]
               	ldrb	w4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x2, #0xe]
               	ldrb	w4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x2, #0xf]
               	ldrb	w4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, lo
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xaa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x5c0
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	ldrb	w7, [x3, x1]
               	cmp	w4, w7
               	b.ge	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xaa0
               	sub	x1, x29, #0x5c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbd0
               	sub	x3, x29, #0xbc0
               	sub	x0, x29, #0x730
               	ldrb	w1, [x2]
               	ldrb	w4, [x3]
               	cmp	w1, w4
               	cset	x1, ls
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrb	w1, [x2, #0x1]
               	ldrb	w4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x2, #0x2]
               	ldrb	w4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x2, #0x3]
               	ldrb	w4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x2, #0x4]
               	ldrb	w4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x2, #0x5]
               	ldrb	w4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x2, #0x6]
               	ldrb	w4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x2, #0x7]
               	ldrb	w4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x2, #0x8]
               	ldrb	w4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x2, #0x9]
               	ldrb	w4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x2, #0xa]
               	ldrb	w4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x2, #0xb]
               	ldrb	w4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x2, #0xc]
               	ldrb	w4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x2, #0xd]
               	ldrb	w4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x2, #0xe]
               	ldrb	w4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x2, #0xf]
               	ldrb	w4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, ls
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x5a0
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	ldrb	w7, [x3, x1]
               	cmp	w4, w7
               	b.gt	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa90
               	sub	x1, x29, #0x5a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbd0
               	sub	x3, x29, #0xbc0
               	sub	x0, x29, #0x730
               	ldrb	w1, [x2]
               	ldrb	w4, [x3]
               	cmp	w1, w4
               	cset	x1, hi
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrb	w1, [x2, #0x1]
               	ldrb	w4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x2, #0x2]
               	ldrb	w4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x2, #0x3]
               	ldrb	w4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x2, #0x4]
               	ldrb	w4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x2, #0x5]
               	ldrb	w4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x2, #0x6]
               	ldrb	w4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x2, #0x7]
               	ldrb	w4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x2, #0x8]
               	ldrb	w4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x2, #0x9]
               	ldrb	w4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x2, #0xa]
               	ldrb	w4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x2, #0xb]
               	ldrb	w4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x2, #0xc]
               	ldrb	w4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x2, #0xd]
               	ldrb	w4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x2, #0xe]
               	ldrb	w4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x2, #0xf]
               	ldrb	w4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, hi
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x580
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	ldrb	w7, [x3, x1]
               	cmp	w4, w7
               	b.le	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa80
               	sub	x1, x29, #0x580
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbd0
               	sub	x3, x29, #0xbc0
               	sub	x0, x29, #0x730
               	ldrb	w1, [x2]
               	ldrb	w4, [x3]
               	cmp	w1, w4
               	cset	x1, hs
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrb	w1, [x2, #0x1]
               	ldrb	w4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x2, #0x2]
               	ldrb	w4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x2, #0x3]
               	ldrb	w4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x2, #0x4]
               	ldrb	w4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x2, #0x5]
               	ldrb	w4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x2, #0x6]
               	ldrb	w4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x2, #0x7]
               	ldrb	w4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x2, #0x8]
               	ldrb	w4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x2, #0x9]
               	ldrb	w4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x2, #0xa]
               	ldrb	w4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x2, #0xb]
               	ldrb	w4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x2, #0xc]
               	ldrb	w4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x2, #0xd]
               	ldrb	w4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x2, #0xe]
               	ldrb	w4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x2, #0xf]
               	ldrb	w4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, hs
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x560
               	sxtw	x1, w0
               	ldrb	w4, [x2, x1]
               	ldrb	w7, [x3, x1]
               	cmp	w4, w7
               	b.lt	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa70
               	sub	x1, x29, #0x560
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, eq
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, eq
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x540
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa60
               	sub	x1, x29, #0x540
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, ne
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, ne
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x520
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.eq	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa50
               	sub	x1, x29, #0x520
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, lt
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, lt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x500
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.ge	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa40
               	sub	x1, x29, #0x500
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, le
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, le
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x4e0
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.gt	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa30
               	sub	x1, x29, #0x4e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, gt
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, gt
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x4c0
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.le	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa20
               	sub	x1, x29, #0x4c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xbb0
               	sub	x3, x29, #0xba0
               	sub	x0, x29, #0x730
               	ldrsb	x1, [x2]
               	ldrsb	x4, [x3]
               	cmp	w1, w4
               	cset	x1, ge
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x1
               	strb	w1, [x0]
               	ldrsb	x1, [x2, #0x1]
               	ldrsb	x4, [x3, #0x1]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x1]
               	ldrsb	x1, [x2, #0x2]
               	ldrsb	x4, [x3, #0x2]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x2]
               	ldrsb	x1, [x2, #0x3]
               	ldrsb	x4, [x3, #0x3]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x3]
               	ldrsb	x1, [x2, #0x4]
               	ldrsb	x4, [x3, #0x4]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x4]
               	ldrsb	x1, [x2, #0x5]
               	ldrsb	x4, [x3, #0x5]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x5]
               	ldrsb	x1, [x2, #0x6]
               	ldrsb	x4, [x3, #0x6]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x6]
               	ldrsb	x1, [x2, #0x7]
               	ldrsb	x4, [x3, #0x7]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x7]
               	ldrsb	x1, [x2, #0x8]
               	ldrsb	x4, [x3, #0x8]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x8]
               	ldrsb	x1, [x2, #0x9]
               	ldrsb	x4, [x3, #0x9]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0x9]
               	ldrsb	x1, [x2, #0xa]
               	ldrsb	x4, [x3, #0xa]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xa]
               	ldrsb	x1, [x2, #0xb]
               	ldrsb	x4, [x3, #0xb]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xb]
               	ldrsb	x1, [x2, #0xc]
               	ldrsb	x4, [x3, #0xc]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xc]
               	ldrsb	x1, [x2, #0xd]
               	ldrsb	x4, [x3, #0xd]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xd]
               	ldrsb	x1, [x2, #0xe]
               	ldrsb	x4, [x3, #0xe]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xe]
               	ldrsb	x1, [x2, #0xf]
               	ldrsb	x4, [x3, #0xf]
               	cmp	w1, w4
               	cset	x1, ge
               	sub	x1, x5, x1
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0xa10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x5
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x6, x29, #0x4a0
               	sxtw	x1, w0
               	ldrsb	x4, [x2, x1]
               	ldrsb	x7, [x3, x1]
               	cmp	w4, w7
               	b.lt	<addr>
               	mov	x4, #-0x1               // =-1
               	b	<addr>
               	mov	x4, x5
               	strb	w4, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0xa10
               	sub	x1, x29, #0x4a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb90
               	sub	x4, x29, #0xb80
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, eq
               	sub	x5, x2, x0
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, eq
               	sub	x6, x2, x0
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, eq
               	sub	x7, x2, x0
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, eq
               	sub	x8, x2, x0
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, eq
               	sub	x9, x2, x0
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, eq
               	sub	x10, x2, x0
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, eq
               	sub	x11, x2, x0
               	sub	x0, x29, #0xa00
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x480
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0xa00
               	sub	x1, x29, #0x480
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb90
               	sub	x4, x29, #0xb80
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x0, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, lo
               	sub	x5, x2, x0
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, lo
               	sub	x6, x2, x0
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, lo
               	sub	x7, x2, x0
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, lo
               	sub	x8, x2, x0
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, lo
               	sub	x9, x2, x0
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, lo
               	sub	x10, x2, x0
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, lo
               	sub	x11, x2, x0
               	sub	x0, x29, #0x9f0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x460
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x9f0
               	sub	x1, x29, #0x460
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb90
               	sub	x4, x29, #0xb80
               	ldrh	w0, [x3]
               	ldrh	w1, [x4]
               	cmp	w0, w1
               	cset	x0, hs
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrh	w0, [x3, #0x2]
               	ldrh	w5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, hs
               	sub	x5, x2, x0
               	ldrh	w0, [x3, #0x4]
               	ldrh	w6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, hs
               	sub	x6, x2, x0
               	ldrh	w0, [x3, #0x6]
               	ldrh	w7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, hs
               	sub	x7, x2, x0
               	ldrh	w0, [x3, #0x8]
               	ldrh	w8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, hs
               	sub	x8, x2, x0
               	ldrh	w0, [x3, #0xa]
               	ldrh	w9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, hs
               	sub	x9, x2, x0
               	ldrh	w0, [x3, #0xc]
               	ldrh	w10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, hs
               	sub	x10, x2, x0
               	ldrh	w0, [x3, #0xe]
               	ldrh	w11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, hs
               	sub	x11, x2, x0
               	sub	x0, x29, #0x9e0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x440
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrh	w6, [x6]
               	add	x1, x4, x1
               	ldrh	w1, [x1]
               	cmp	w6, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x9e0
               	sub	x1, x29, #0x440
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb70
               	sub	x4, x29, #0xb60
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x0, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, ne
               	sub	x5, x2, x0
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, ne
               	sub	x6, x2, x0
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, ne
               	sub	x7, x2, x0
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, ne
               	sub	x8, x2, x0
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, ne
               	sub	x9, x2, x0
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, ne
               	sub	x10, x2, x0
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, ne
               	sub	x11, x2, x0
               	sub	x0, x29, #0x9d0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x420
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x9d0
               	sub	x1, x29, #0x420
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb70
               	sub	x4, x29, #0xb60
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x0, le
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, le
               	sub	x5, x2, x0
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, le
               	sub	x6, x2, x0
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, le
               	sub	x7, x2, x0
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, le
               	sub	x8, x2, x0
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, le
               	sub	x9, x2, x0
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, le
               	sub	x10, x2, x0
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, le
               	sub	x11, x2, x0
               	sub	x0, x29, #0x9c0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x400
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.gt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x9c0
               	sub	x1, x29, #0x400
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb70
               	sub	x4, x29, #0xb60
               	ldrsh	x0, [x3]
               	ldrsh	x1, [x4]
               	cmp	w0, w1
               	cset	x0, gt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsh	x0, [x3, #0x2]
               	ldrsh	x5, [x4, #0x2]
               	cmp	w0, w5
               	cset	x0, gt
               	sub	x5, x2, x0
               	ldrsh	x0, [x3, #0x4]
               	ldrsh	x6, [x4, #0x4]
               	cmp	w0, w6
               	cset	x0, gt
               	sub	x6, x2, x0
               	ldrsh	x0, [x3, #0x6]
               	ldrsh	x7, [x4, #0x6]
               	cmp	w0, w7
               	cset	x0, gt
               	sub	x7, x2, x0
               	ldrsh	x0, [x3, #0x8]
               	ldrsh	x8, [x4, #0x8]
               	cmp	w0, w8
               	cset	x0, gt
               	sub	x8, x2, x0
               	ldrsh	x0, [x3, #0xa]
               	ldrsh	x9, [x4, #0xa]
               	cmp	w0, w9
               	cset	x0, gt
               	sub	x9, x2, x0
               	ldrsh	x0, [x3, #0xc]
               	ldrsh	x10, [x4, #0xc]
               	cmp	w0, w10
               	cset	x0, gt
               	sub	x10, x2, x0
               	ldrsh	x0, [x3, #0xe]
               	ldrsh	x11, [x4, #0xe]
               	cmp	w0, w11
               	cset	x0, gt
               	sub	x11, x2, x0
               	sub	x0, x29, #0x9b0
               	and	x1, x1, #0xffff
               	strh	w1, [x0]
               	and	x1, x5, #0xffff
               	strh	w1, [x0, #0x2]
               	and	x1, x6, #0xffff
               	strh	w1, [x0, #0x4]
               	and	x1, x7, #0xffff
               	strh	w1, [x0, #0x6]
               	and	x1, x8, #0xffff
               	strh	w1, [x0, #0x8]
               	and	x1, x9, #0xffff
               	strh	w1, [x0, #0xa]
               	and	x1, x10, #0xffff
               	strh	w1, [x0, #0xc]
               	and	x1, x11, #0xffff
               	strh	w1, [x0, #0xe]
               	mov	x0, x2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x3e0
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsh	x6, [x6]
               	add	x1, x4, x1
               	ldrsh	x1, [x1]
               	cmp	w6, w1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	strh	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x9b0
               	sub	x1, x29, #0x3e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb50
               	sub	x4, x29, #0xb40
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x0, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	cmp	w0, w5
               	cset	x0, lo
               	sub	x5, x2, x0
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	cmp	w0, w6
               	cset	x0, lo
               	sub	x6, x2, x0
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	cmp	w0, w7
               	cset	x0, lo
               	sub	x7, x2, x0
               	sub	x0, x29, #0x9a0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x3c0
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	cmp	w6, w1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x9a0
               	sub	x1, x29, #0x3c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb50
               	sub	x4, x29, #0xb40
               	ldr	w0, [x3]
               	ldr	w1, [x4]
               	cmp	w0, w1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	w0, [x3, #0x4]
               	ldr	w5, [x4, #0x4]
               	cmp	w0, w5
               	cset	x0, eq
               	sub	x5, x2, x0
               	ldr	w0, [x3, #0x8]
               	ldr	w6, [x4, #0x8]
               	cmp	w0, w6
               	cset	x0, eq
               	sub	x6, x2, x0
               	ldr	w0, [x3, #0xc]
               	ldr	w7, [x4, #0xc]
               	cmp	w0, w7
               	cset	x0, eq
               	sub	x7, x2, x0
               	sub	x0, x29, #0x990
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x3a0
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	w6, [x6]
               	add	x1, x4, x1
               	ldr	w1, [x1]
               	cmp	w6, w1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x990
               	sub	x1, x29, #0x3a0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb30
               	sub	x4, x29, #0xb20
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x0, lt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	cmp	w0, w5
               	cset	x0, lt
               	sub	x5, x2, x0
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	cmp	w0, w6
               	cset	x0, lt
               	sub	x6, x2, x0
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	cmp	w0, w7
               	cset	x0, lt
               	sub	x7, x2, x0
               	sub	x0, x29, #0x980
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x380
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x980
               	sub	x1, x29, #0x380
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb30
               	sub	x4, x29, #0xb20
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	cmp	w0, w5
               	cset	x0, ge
               	sub	x5, x2, x0
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	cmp	w0, w6
               	cset	x0, ge
               	sub	x6, x2, x0
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	cmp	w0, w7
               	cset	x0, ge
               	sub	x7, x2, x0
               	sub	x0, x29, #0x970
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x360
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x970
               	sub	x1, x29, #0x360
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb30
               	sub	x4, x29, #0xb20
               	ldrsw	x0, [x3]
               	ldrsw	x1, [x4]
               	cmp	w0, w1
               	cset	x0, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldrsw	x0, [x3, #0x4]
               	ldrsw	x5, [x4, #0x4]
               	cmp	w0, w5
               	cset	x0, ne
               	sub	x5, x2, x0
               	ldrsw	x0, [x3, #0x8]
               	ldrsw	x6, [x4, #0x8]
               	cmp	w0, w6
               	cset	x0, ne
               	sub	x6, x2, x0
               	ldrsw	x0, [x3, #0xc]
               	ldrsw	x7, [x4, #0xc]
               	cmp	w0, w7
               	cset	x0, ne
               	sub	x7, x2, x0
               	sub	x0, x29, #0x960
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x340
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldrsw	x6, [x6]
               	add	x1, x4, x1
               	ldrsw	x1, [x1]
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x960
               	sub	x1, x29, #0x340
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb10
               	sub	x4, x29, #0xb00
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x0, lo
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	cmp	x0, x5
               	cset	x0, lo
               	sub	x5, x2, x0
               	sub	x0, x29, #0x950
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x320
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.hs	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x950
               	sub	x1, x29, #0x320
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb10
               	sub	x4, x29, #0xb00
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x0, hi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	cmp	x0, x5
               	cset	x0, hi
               	sub	x5, x2, x0
               	sub	x0, x29, #0x940
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x300
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ls	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x940
               	sub	x1, x29, #0x300
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xaf0
               	sub	x4, x29, #0xae0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x0, lt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	cmp	x0, x5
               	cset	x0, lt
               	sub	x5, x2, x0
               	sub	x0, x29, #0x930
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x2e0
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x930
               	sub	x1, x29, #0x2e0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xaf0
               	sub	x4, x29, #0xae0
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	cmp	x0, x1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	x0, [x3, #0x8]
               	ldr	x5, [x4, #0x8]
               	cmp	x0, x5
               	cset	x0, eq
               	sub	x5, x2, x0
               	sub	x0, x29, #0x920
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x2c0
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	x6, [x6]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	cmp	x6, x1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x920
               	sub	x1, x29, #0x2c0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x740
               	sub	x4, x29, #0x738
               	ldrb	w0, [x3]
               	ldrb	w1, [x4]
               	cmp	w0, w1
               	cset	x0, lo
               	mov	x5, #0x0                // =0
               	sub	x1, x5, x0
               	ldrb	w0, [x3, #0x1]
               	ldrb	w2, [x4, #0x1]
               	cmp	w0, w2
               	cset	x0, lo
               	sub	x2, x5, x0
               	ldrb	w0, [x3, #0x2]
               	ldrb	w6, [x4, #0x2]
               	cmp	w0, w6
               	cset	x0, lo
               	sub	x6, x5, x0
               	ldrb	w0, [x3, #0x3]
               	ldrb	w7, [x4, #0x3]
               	cmp	w0, w7
               	cset	x0, lo
               	sub	x7, x5, x0
               	ldrb	w0, [x3, #0x4]
               	ldrb	w8, [x4, #0x4]
               	cmp	w0, w8
               	cset	x0, lo
               	sub	x8, x5, x0
               	ldrb	w0, [x3, #0x5]
               	ldrb	w9, [x4, #0x5]
               	cmp	w0, w9
               	cset	x0, lo
               	sub	x9, x5, x0
               	ldrb	w0, [x3, #0x6]
               	ldrb	w10, [x4, #0x6]
               	cmp	w0, w10
               	cset	x0, lo
               	sub	x10, x5, x0
               	ldrb	w0, [x3, #0x7]
               	ldrb	w11, [x4, #0x7]
               	cmp	w0, w11
               	cset	x0, lo
               	sub	x11, x5, x0
               	sub	x0, x29, #0x2b0
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	and	x1, x2, #0xff
               	strb	w1, [x0, #0x1]
               	and	x1, x6, #0xff
               	strb	w1, [x0, #0x2]
               	and	x1, x7, #0xff
               	strb	w1, [x0, #0x3]
               	and	x1, x8, #0xff
               	strb	w1, [x0, #0x4]
               	and	x1, x9, #0xff
               	strb	w1, [x0, #0x5]
               	and	x1, x10, #0xff
               	strb	w1, [x0, #0x6]
               	and	x1, x11, #0xff
               	strb	w1, [x0, #0x7]
               	mov	x0, x5
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x6, x29, #0x2a8
               	sxtw	x1, w0
               	ldrb	w2, [x3, x1]
               	ldrb	w7, [x4, x1]
               	cmp	w2, w7
               	b.ge	<addr>
               	mov	x2, #-0x1               // =-1
               	b	<addr>
               	mov	x2, x5
               	strb	w2, [x6, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x2b0
               	sub	x1, x29, #0x2a8
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x728
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
               	sub	x3, x29, #0x910
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x900
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
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, eq
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, eq
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, eq
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8f0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x270
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8f0
               	sub	x1, x29, #0x270
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	sub	x4, x29, #0x900
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x0, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, ne
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, ne
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, ne
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8e0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x250
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8e0
               	sub	x1, x29, #0x250
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	sub	x4, x29, #0x900
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x0, mi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, mi
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, mi
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, mi
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8d0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x230
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8d0
               	sub	x1, x29, #0x230
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	sub	x4, x29, #0x900
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x0, ls
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, ls
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, ls
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, ls
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8c0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x210
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.hi	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8c0
               	sub	x1, x29, #0x210
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	sub	x4, x29, #0x900
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x0, gt
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, gt
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, gt
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, gt
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8b0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x1f0
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8b0
               	sub	x1, x29, #0x1f0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	sub	x4, x29, #0x900
               	ldr	s0, [x3]
               	ldr	s1, [x4]
               	fcmp	s0, s1
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	s0, [x3, #0x4]
               	ldr	s1, [x4, #0x4]
               	fcmp	s0, s1
               	cset	x0, ge
               	sub	x5, x2, x0
               	ldr	s0, [x3, #0x8]
               	ldr	s1, [x4, #0x8]
               	fcmp	s0, s1
               	cset	x0, ge
               	sub	x6, x2, x0
               	ldr	s0, [x3, #0xc]
               	ldr	s1, [x4, #0xc]
               	fcmp	s0, s1
               	cset	x0, ge
               	sub	x7, x2, x0
               	sub	x0, x29, #0x8a0
               	mov	w1, w1
               	str	w1, [x0]
               	mov	w1, w5
               	str	w1, [x0, #0x4]
               	mov	w1, w6
               	str	w1, [x0, #0x8]
               	mov	w1, w7
               	str	w1, [x0, #0xc]
               	mov	x0, x2
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x1d0
               	sxtw	x1, w0
               	lsl	x1, x1, #2
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	s0, [x6]
               	add	x1, x4, x1
               	ldr	s1, [x1]
               	fcmp	s0, s1
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	w1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x8a0
               	sub	x1, x29, #0x1d0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x910
               	mov	x4, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x4
               	fcvt	s0, d16
               	ldr	s1, [x3]
               	fcmp	s1, s0
               	cset	x0, gt
               	mov	x1, #0x0                // =0
               	sub	x2, x1, x0
               	ldr	s1, [x3, #0x4]
               	fcmp	s1, s0
               	cset	x0, gt
               	sub	x5, x1, x0
               	ldr	s1, [x3, #0x8]
               	fcmp	s1, s0
               	cset	x0, gt
               	sub	x6, x1, x0
               	ldr	s1, [x3, #0xc]
               	fcmp	s1, s0
               	cset	x0, gt
               	sub	x7, x1, x0
               	sub	x0, x29, #0x890
               	mov	w2, w2
               	str	w2, [x0]
               	mov	w2, w5
               	str	w2, [x0, #0x4]
               	mov	w2, w6
               	str	w2, [x0, #0x8]
               	mov	w2, w7
               	str	w2, [x0, #0xc]
               	mov	x0, x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x1b0
               	sxtw	x2, w0
               	lsl	x2, x2, #2
               	add	x5, x5, x2
               	add	x2, x3, x2
               	ldr	s1, [x2]
               	fcmp	s1, s0
               	b.le	<addr>
               	mov	x2, #-0x1               // =-1
               	b	<addr>
               	mov	x2, x1
               	str	w2, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x890
               	sub	x1, x29, #0x1b0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x728
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x880
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x870
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
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x0, eq
               	sub	x5, x2, x0
               	sub	x0, x29, #0x860
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x170
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x860
               	sub	x1, x29, #0x170
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x880
               	sub	x4, x29, #0x870
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x0, ne
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x0, ne
               	sub	x5, x2, x0
               	sub	x0, x29, #0x850
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x150
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x850
               	sub	x1, x29, #0x150
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x880
               	sub	x4, x29, #0x870
               	ldr	d0, [x3]
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x0, mi
               	mov	x2, #0x0                // =0
               	sub	x1, x2, x0
               	ldr	d0, [x3, #0x8]
               	ldr	d1, [x4, #0x8]
               	fcmp	d0, d1
               	cset	x0, mi
               	sub	x5, x2, x0
               	sub	x0, x29, #0x840
               	str	x1, [x0]
               	str	x5, [x0, #0x8]
               	mov	x0, x2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x130
               	sxtw	x1, w0
               	lsl	x1, x1, #3
               	add	x5, x5, x1
               	add	x6, x3, x1
               	ldr	d0, [x6]
               	add	x1, x4, x1
               	ldr	d1, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, x2
               	str	x1, [x5]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x840
               	sub	x1, x29, #0x130
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xbd0
               	sub	x0, x29, #0x730
               	ldrb	w2, [x1]
               	cmp	w2, #0x64
               	cset	x2, hi
               	mov	x4, #0x0                // =0
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	cmp	w2, #0x64
               	cset	x2, hi
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x830
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0x110
               	sxtw	x2, w0
               	ldrb	w3, [x1, x2]
               	cmp	w3, #0x64
               	b.le	<addr>
               	mov	x3, #-0x1               // =-1
               	b	<addr>
               	mov	x3, x4
               	strb	w3, [x5, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x830
               	sub	x1, x29, #0x110
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xbd0
               	sub	x0, x29, #0x730
               	ldrb	w2, [x1]
               	cmp	w2, #0x3
               	cset	x2, eq
               	mov	x4, #0x0                // =0
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	cmp	w2, #0x3
               	cset	x2, eq
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x820
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0xf0
               	sxtw	x2, w0
               	ldrb	w3, [x1, x2]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	mov	x3, #-0x1               // =-1
               	b	<addr>
               	mov	x3, x4
               	strb	w3, [x5, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x820
               	sub	x1, x29, #0xf0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xbd0
               	sub	x0, x29, #0x730
               	ldrb	w2, [x1]
               	cmp	w2, #0xff
               	cset	x2, lo
               	mov	x4, #0x0                // =0
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	cmp	w2, #0xff
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x810
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0xd0
               	sxtw	x2, w0
               	ldrb	w3, [x1, x2]
               	cmp	w3, #0xff
               	b.ge	<addr>
               	mov	x3, #-0x1               // =-1
               	b	<addr>
               	mov	x3, x4
               	strb	w3, [x5, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x810
               	sub	x1, x29, #0xd0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xbb0
               	mov	x2, #-0x5               // =-5
               	sub	x0, x29, #0x730
               	ldrsb	x3, [x1]
               	cmp	w3, w2
               	cset	x3, gt
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	strb	w3, [x0]
               	ldrsb	x3, [x1, #0x1]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x1]
               	ldrsb	x3, [x1, #0x2]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x2]
               	ldrsb	x3, [x1, #0x3]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x3]
               	ldrsb	x3, [x1, #0x4]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x4]
               	ldrsb	x3, [x1, #0x5]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x5]
               	ldrsb	x3, [x1, #0x6]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x6]
               	ldrsb	x3, [x1, #0x7]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x7]
               	ldrsb	x3, [x1, #0x8]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x8]
               	ldrsb	x3, [x1, #0x9]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0x9]
               	ldrsb	x3, [x1, #0xa]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xa]
               	ldrsb	x3, [x1, #0xb]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xb]
               	ldrsb	x3, [x1, #0xc]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xc]
               	ldrsb	x3, [x1, #0xd]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xd]
               	ldrsb	x3, [x1, #0xe]
               	cmp	w3, w2
               	cset	x3, gt
               	sub	x3, x4, x3
               	strb	w3, [x0, #0xe]
               	ldrsb	x3, [x1, #0xf]
               	cmp	w3, w2
               	cset	x2, gt
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x800
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x6, #-0x5               // =-5
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0xb0
               	sxtw	x2, w0
               	ldrsb	x3, [x1, x2]
               	cmp	w3, w6
               	b.le	<addr>
               	mov	x3, #-0x1               // =-1
               	b	<addr>
               	mov	x3, x4
               	strb	w3, [x5, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x800
               	sub	x1, x29, #0xb0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb30
               	mov	x1, #0x0                // =0
               	ldrsw	x0, [x3]
               	cmp	w0, #0x0
               	cset	x0, lt
               	sub	x2, x1, x0
               	ldrsw	x0, [x3, #0x4]
               	cmp	w0, #0x0
               	cset	x0, lt
               	sub	x4, x1, x0
               	ldrsw	x0, [x3, #0x8]
               	cmp	w0, #0x0
               	cset	x0, lt
               	sub	x5, x1, x0
               	ldrsw	x0, [x3, #0xc]
               	cmp	w0, #0x0
               	cset	x0, lt
               	sub	x6, x1, x0
               	sub	x0, x29, #0x7f0
               	mov	w2, w2
               	str	w2, [x0]
               	mov	w2, w4
               	str	w2, [x0, #0x4]
               	mov	w2, w5
               	str	w2, [x0, #0x8]
               	mov	w2, w6
               	str	w2, [x0, #0xc]
               	mov	x0, x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x4, x29, #0x90
               	sxtw	x2, w0
               	lsl	x2, x2, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mov	x2, #-0x1               // =-1
               	b	<addr>
               	mov	x2, x1
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x7f0
               	sub	x1, x29, #0x90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0xb10
               	ldr	x0, [x3]
               	cmp	x0, #0x5
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	sub	x2, x1, x0
               	ldr	x0, [x3, #0x8]
               	cmp	x0, #0x5
               	cset	x0, ne
               	sub	x4, x1, x0
               	sub	x0, x29, #0x7e0
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	mov	x0, x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x70
               	sxtw	x2, w0
               	lsl	x2, x2, #3
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldr	x2, [x2]
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x2, #-0x1               // =-1
               	b	<addr>
               	mov	x2, x1
               	str	x2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x7e0
               	sub	x1, x29, #0x70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xbd0
               	sub	x0, x29, #0x730
               	ldrb	w2, [x1]
               	cmp	w2, #0x64
               	cset	x2, lo
               	mov	x4, #0x0                // =0
               	sub	x2, x4, x2
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w2, [x1, #0xf]
               	cmp	w2, #0x64
               	cset	x2, lo
               	sub	x2, x4, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x7d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0x50
               	sxtw	x2, w0
               	ldrb	w3, [x1, x2]
               	cmp	w3, #0x64
               	b.ge	<addr>
               	mov	x3, #-0x1               // =-1
               	b	<addr>
               	mov	x3, x4
               	strb	w3, [x5, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x7d0
               	sub	x1, x29, #0x50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	sub	x3, x29, #0xb30
               	ldrsw	x0, [x3]
               	cmp	w0, #0x0
               	cset	x0, ge
               	sub	x2, x1, x0
               	ldrsw	x0, [x3, #0x4]
               	cmp	w0, #0x0
               	cset	x0, ge
               	sub	x4, x1, x0
               	ldrsw	x0, [x3, #0x8]
               	cmp	w0, #0x0
               	cset	x0, ge
               	sub	x5, x1, x0
               	ldrsw	x0, [x3, #0xc]
               	cmp	w0, #0x0
               	cset	x0, ge
               	sub	x6, x1, x0
               	sub	x0, x29, #0x7c0
               	mov	w2, w2
               	str	w2, [x0]
               	mov	w2, w4
               	str	w2, [x0, #0x4]
               	mov	w2, w5
               	str	w2, [x0, #0x8]
               	mov	w2, w6
               	str	w2, [x0, #0xc]
               	mov	x0, x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x4, x29, #0x30
               	sxtw	x2, w0
               	lsl	x2, x2, #2
               	add	x4, x4, x2
               	add	x2, x3, x2
               	ldrsw	x2, [x2]
               	cmp	w2, #0x0
               	b.lt	<addr>
               	mov	x2, #-0x1               // =-1
               	b	<addr>
               	mov	x2, x1
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x7c0
               	sub	x1, x29, #0x30
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x780
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x770
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x730
               	mov	x2, #-0x1               // =-1
               	str	w2, [x0]
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x4]
               	str	w2, [x0, #0x8]
               	str	w1, [x0, #0xc]
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x5, lsl #32
               	and	x6, x3, x17
               	mov	x17, #0x3               // =3
               	movk	x17, #0x9, lsl #32
               	and	x4, x4, x17
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	add	x3, x0, #0x8
               	str	w1, [x3]
               	str	w2, [x0, #0xc]
               	ldr	x5, [x0]
               	mov	x17, #0x2               // =2
               	movk	x17, #0x4, lsl #32
               	and	x5, x5, x17
               	ldr	x2, [x3]
               	mov	x17, #0x6               // =6
               	movk	x17, #0x8, lsl #32
               	and	x2, x2, x17
               	orr	x3, x6, x5
               	str	x3, [x0]
               	orr	x2, x4, x2
               	str	x2, [x0, #0x8]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x0, #0x8]
               	ldr	w0, [x0, #0xc]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	cmp	w3, #0x4
               	b.ne	<addr>
               	cmp	w4, #0x3
               	b.ne	<addr>
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xbd0
               	ldp	x29, x30, [sp], #0x10
               	ret
