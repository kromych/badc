
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
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
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
               	mov	x7, #0x1                // =1
               	strb	w7, [x0]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x3]
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x5]
               	mov	x17, #0xffff            // =65535
               	add	x14, x0, x17
               	mov	x1, #0x7                // =7
               	strb	w1, [x14]
               	ldrb	w12, [x0]
               	ldrb	w8, [x0, #0x1]
               	ldrb	w9, [x0, #0x2]
               	ldrb	w10, [x0, #0x3]
               	ldrb	w11, [x0, #0x4]
               	ldrb	w13, [x0, #0x5]
               	add	x1, x12, x8
               	add	x2, x9, x10
               	add	x3, x11, x13
               	mov	x17, #0x3               // =3
               	mul	x4, x1, x17
               	mov	x17, #0x5               // =5
               	mul	x5, x2, x17
               	mov	x17, #0x7               // =7
               	mul	x6, x3, x17
               	cmp	x1, x2
               	b.ge	<addr>
               	mov	x15, x4
               	cmp	x2, x3
               	b.ge	<addr>
               	mov	x20, x5
               	cmp	x3, x1
               	b.ge	<addr>
               	mov	x21, x6
               	add	x22, x1, x9
               	add	x22, x22, x10
               	add	x22, x22, x11
               	add	x22, x22, x13
               	add	x22, x22, x1
               	add	x22, x22, x2
               	add	x22, x22, x3
               	add	x22, x22, x4
               	add	x22, x22, x5
               	add	x22, x22, x6
               	add	x15, x22, x15
               	add	x15, x15, x20
               	add	x15, x15, x21
               	cmp	w12, w8
               	cset	x12, lt
               	cmp	w8, w9
               	cset	x8, lt
               	add	x8, x12, x8
               	cmp	w9, w10
               	cset	x9, lt
               	add	x8, x8, x9
               	cmp	w10, w11
               	cset	x9, lt
               	add	x8, x8, x9
               	cmp	w11, w13
               	cset	x9, lt
               	add	x8, x8, x9
               	cmp	x1, x2
               	cset	x1, gt
               	add	x1, x8, x1
               	cmp	x2, x3
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
               	sxtw	x1, w1
               	add	x2, x15, x1
               	mov	x1, #0x0                // =0
               	ldrb	w3, [x0]
               	ldrb	w4, [x14]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x2]
               	ldrb	w0, [x0, #0x3]
               	add	x0, x4, x0
               	cmp	x2, #0xe0
               	b.ne	<addr>
               	cmp	x3, #0x8
               	cset	x1, eq
               	cbz	x1, <addr>
               	cmp	x0, #0x7
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x7, #0x2a               // =42
               	sxtw	x0, w7
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x21, x4
               	b	<addr>
               	mov	x20, x6
               	b	<addr>
               	mov	x15, x5
               	b	<addr>
