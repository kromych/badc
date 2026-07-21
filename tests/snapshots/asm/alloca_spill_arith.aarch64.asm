
alloca_spill_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x120]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x0, #0x10000            // =65536
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
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
               	add	x1, x0, x17
               	mov	x2, #0x7                // =7
               	strb	w2, [x1]
               	ldrb	w11, [x0]
               	ldrb	w7, [x0, #0x1]
               	ldrb	w8, [x0, #0x2]
               	ldrb	w9, [x0, #0x3]
               	ldrb	w10, [x0, #0x4]
               	ldrb	w12, [x0, #0x5]
               	add	x2, x11, x7
               	add	x1, x8, x9
               	add	x3, x10, x12
               	mov	x17, #0x3               // =3
               	mul	x4, x2, x17
               	mov	x17, #0x5               // =5
               	mul	x5, x1, x17
               	mov	x17, #0x7               // =7
               	mul	x6, x3, x17
               	cmp	x2, x1
               	b.ge	<addr>
               	mov	x13, x4
               	cmp	x1, x3
               	b.ge	<addr>
               	mov	x14, x5
               	cmp	x3, x2
               	b.ge	<addr>
               	mov	x15, x6
               	add	x20, x11, x7
               	add	x20, x20, x8
               	add	x20, x20, x9
               	add	x20, x20, x10
               	add	x20, x20, x12
               	add	x20, x20, x2
               	add	x20, x20, x1
               	add	x20, x20, x3
               	add	x20, x20, x4
               	add	x20, x20, x5
               	add	x20, x20, x6
               	add	x13, x20, x13
               	add	x13, x13, x14
               	add	x13, x13, x15
               	cmp	x11, x7
               	cset	x11, lt
               	cmp	x7, x8
               	cset	x7, lt
               	add	x7, x11, x7
               	cmp	x8, x9
               	cset	x8, lt
               	add	x7, x7, x8
               	cmp	x9, x10
               	cset	x8, lt
               	add	x7, x7, x8
               	cmp	x10, x12
               	cset	x8, lt
               	add	x7, x7, x8
               	cmp	x2, x1
               	cset	x2, gt
               	add	x2, x7, x2
               	cmp	x1, x3
               	cset	x1, gt
               	add	x1, x2, x1
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
               	add	x2, x13, x1
               	mov	x1, #0x0                // =0
               	ldrb	w3, [x0]
               	mov	x17, #0xffff            // =65535
               	add	x4, x0, x17
               	ldrb	w4, [x4]
               	add	x3, x3, x4
               	ldrb	w4, [x0, #0x2]
               	ldrb	w0, [x0, #0x3]
               	add	x0, x4, x0
               	cmp	x2, #0xe0
               	cset	x2, eq
               	cbz	x2, <addr>
               	cmp	x3, #0x8
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	cmp	x0, #0x7
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x110
               	ldp	x29, x30, [sp, #0x110]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x15, x4
               	b	<addr>
               	mov	x14, x6
               	b	<addr>
               	mov	x13, x5
               	b	<addr>
