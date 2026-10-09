
alloca_spill_arith.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x10000            // =65536
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	strb	w2, [x0, #0x5]
               	mov	x17, #0xffff            // =65535
               	add	x12, x0, x17
               	ldrb	w1, [x1, #0x6]
               	strb	w1, [x12]
               	ldrb	w13, [x0]
               	ldrb	w10, [x0, #0x1]
               	ldrb	w7, [x0, #0x2]
               	ldrb	w8, [x0, #0x3]
               	ldrb	w9, [x0, #0x4]
               	ldrb	w11, [x0, #0x5]
               	add	x1, x13, x10
               	add	x2, x7, x8
               	add	x3, x9, x11
               	mov	x17, #0x3               // =3
               	mul	x4, x1, x17
               	mov	x17, #0x5               // =5
               	mul	x5, x2, x17
               	mov	x17, #0x7               // =7
               	mul	x6, x3, x17
               	cmp	w1, w2
               	b.ge	<addr>
               	mov	x14, x4
               	cmp	w2, w3
               	b.ge	<addr>
               	mov	x15, x5
               	cmp	w3, w1
               	b.ge	<addr>
               	mov	x20, x6
               	add	x21, x1, x7
               	add	x21, x21, x8
               	add	x21, x21, x9
               	add	x21, x21, x11
               	add	x21, x21, x1
               	add	x21, x21, x2
               	add	x21, x21, x3
               	add	x21, x21, x4
               	add	x21, x21, x5
               	add	x21, x21, x6
               	add	x14, x21, x14
               	add	x14, x14, x15
               	add	x14, x14, x20
               	cmp	w13, w10
               	cset	x13, lt
               	cmp	w10, w7
               	cset	x10, lt
               	add	x10, x13, x10
               	cmp	w7, w8
               	cset	x7, lt
               	add	x7, x10, x7
               	cmp	w8, w9
               	cset	x8, lt
               	add	x7, x7, x8
               	cmp	w9, w11
               	cset	x8, lt
               	add	x7, x7, x8
               	cmp	w1, w2
               	cset	x1, gt
               	add	x1, x7, x1
               	cmp	w2, w3
               	cset	x2, gt
               	add	x1, x1, x2
               	cmp	x4, x5
               	cset	x2, ne
               	add	x1, x1, x2
               	cmp	x5, x6
               	cset	x2, ne
               	add	x1, x1, x2
               	cmp	x6, x4
               	cset	x2, ne
               	add	x1, x1, x2
               	add	x1, x14, x1
               	ldrb	w2, [x0]
               	ldrb	w3, [x12]
               	add	x2, x2, x3
               	ldrb	w3, [x0, #0x2]
               	ldrb	w0, [x0, #0x3]
               	add	x0, x3, x0
               	cmp	x1, #0xe0
               	b.ne	<addr>
               	cmp	w2, #0x8
               	b.ne	<addr>
               	cmp	w0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x20, x4
               	b	<addr>
               	mov	x15, x6
               	b	<addr>
               	mov	x14, x5
               	b	<addr>
