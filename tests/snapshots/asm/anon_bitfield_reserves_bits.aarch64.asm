
anon_bitfield_reserves_bits.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x20, x29, #0x20
               	mov	x22, #0x0               // =0
               	mov	x23, #0x4               // =4
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	mov	x21, #0x1               // =1
               	ldrb	w0, [x20, #0x2]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	orr	x0, x0, x23
               	strb	w0, [x20, #0x2]
               	ldrb	w0, [x20]
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x2]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x23, #0x4               // =4
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sub	x22, x29, #0x20
               	ldrb	w0, [x22, #0x2]
               	mov	x17, #0xff07            // =65287
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xf8              // =248
               	orr	x0, x0, x17
               	strb	w0, [x22, #0x2]
               	ldrb	w0, [x20]
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x2]
               	mov	x17, #0xf8              // =248
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbnz	x21, <addr>
               	ldrb	w0, [x20, #0x3]
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x24, #0x0               // =0
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x24
               	bl	<addr>
               	ldrb	w0, [x22, #0x3]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x7f              // =127
               	orr	x0, x0, x17
               	strb	w0, [x22, #0x3]
               	ldrb	w0, [x20]
               	mov	x21, #0x1               // =1
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x2]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	mov	x17, #0x7f              // =127
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x24
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	orr	x1, x1, x23
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0xff07            // =65287
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x48              // =72
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x64              // =100
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x0, #0x2]
               	asr	x1, x1, #2
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	asr	x1, x1, #3
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x9
               	cset	x21, ne
               	cbnz	x21, <addr>
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	x0, #0x64
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x20, x29, #0x18
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0xff               // =255
               	strb	w0, [x20, #0x3]
               	ldrb	w0, [x20]
               	mov	x22, #0x1               // =1
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x2]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x20, x29, #0x10
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	str	w22, [x20]
               	mov	x0, #0x3344             // =13124
               	movk	x0, #0x1122, lsl #16
               	str	w0, [x20, #0x8]
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	str	w0, [x20, #0xc]
               	ldr	w0, [x20]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	eor	x1, x1, x17
               	mov	w2, w1
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldr	w1, [x0, #0xc]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	add	x1, x0, #0x8
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, x22
               	b	<addr>
               	mov	x0, x22
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
               	mov	x0, x21
               	b	<addr>
