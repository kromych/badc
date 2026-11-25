
chacha20_block_on_a_local_array.aarch64:	file format elf64-littleaarch64

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

<chacha_block>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x22, x0
               	mov	x21, x1
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	ldr	w15, [x21, #0x8]
               	ldr	w14, [x21, #0xc]
               	ldr	w13, [x21, #0x10]
               	ldr	w12, [x21, #0x14]
               	ldr	w11, [x21, #0x18]
               	ldr	w10, [x21, #0x1c]
               	ldr	w9, [x21, #0x20]
               	ldr	w8, [x21, #0x24]
               	ldr	w7, [x21, #0x28]
               	ldr	w6, [x21, #0x2c]
               	ldr	w5, [x21, #0x30]
               	ldr	w4, [x21, #0x34]
               	ldr	w3, [x21, #0x38]
               	ldr	w2, [x21, #0x3c]
               	mov	x20, #0x0               // =0
               	add	x1, x1, x13
               	mov	w5, w5
               	mov	w23, w1
               	eor	x5, x5, x23
               	ror	w5, w5, #0x10
               	add	x9, x9, x5
               	mov	w13, w13
               	mov	w23, w9
               	eor	x13, x13, x23
               	ror	w13, w13, #0x14
               	add	x1, x1, x13
               	mov	w5, w5
               	mov	w23, w1
               	eor	x5, x5, x23
               	ror	w5, w5, #0x18
               	add	x9, x9, x5
               	mov	w13, w13
               	mov	w23, w9
               	eor	x13, x13, x23
               	ror	w13, w13, #0x19
               	add	x0, x0, x12
               	mov	w4, w4
               	mov	w23, w0
               	eor	x4, x4, x23
               	ror	w4, w4, #0x10
               	add	x8, x8, x4
               	mov	w12, w12
               	mov	w23, w8
               	eor	x12, x12, x23
               	ror	w12, w12, #0x14
               	add	x0, x0, x12
               	mov	w4, w4
               	mov	w23, w0
               	eor	x4, x4, x23
               	ror	w4, w4, #0x18
               	add	x8, x8, x4
               	mov	w12, w12
               	mov	w23, w8
               	eor	x12, x12, x23
               	ror	w12, w12, #0x19
               	add	x15, x15, x11
               	mov	w3, w3
               	mov	w23, w15
               	eor	x3, x3, x23
               	ror	w3, w3, #0x10
               	add	x7, x7, x3
               	mov	w11, w11
               	mov	w23, w7
               	eor	x11, x11, x23
               	ror	w11, w11, #0x14
               	add	x15, x15, x11
               	mov	w3, w3
               	mov	w23, w15
               	eor	x3, x3, x23
               	ror	w3, w3, #0x18
               	add	x7, x7, x3
               	mov	w11, w11
               	mov	w23, w7
               	eor	x11, x11, x23
               	ror	w11, w11, #0x19
               	add	x14, x14, x10
               	mov	w2, w2
               	mov	w23, w14
               	eor	x2, x2, x23
               	ror	w2, w2, #0x10
               	add	x6, x6, x2
               	mov	w10, w10
               	mov	w23, w6
               	eor	x10, x10, x23
               	ror	w10, w10, #0x14
               	add	x14, x14, x10
               	mov	w2, w2
               	mov	w23, w14
               	eor	x2, x2, x23
               	ror	w2, w2, #0x18
               	add	x6, x6, x2
               	mov	w10, w10
               	mov	w23, w6
               	eor	x10, x10, x23
               	ror	w10, w10, #0x19
               	add	x1, x1, x12
               	mov	w2, w2
               	mov	w23, w1
               	eor	x2, x2, x23
               	ror	w2, w2, #0x10
               	add	x7, x7, x2
               	mov	w12, w12
               	mov	w23, w7
               	eor	x12, x12, x23
               	ror	w12, w12, #0x14
               	add	x1, x1, x12
               	mov	w2, w2
               	mov	w23, w1
               	eor	x2, x2, x23
               	ror	w2, w2, #0x18
               	add	x7, x7, x2
               	mov	w12, w12
               	mov	w23, w7
               	eor	x12, x12, x23
               	ror	w12, w12, #0x19
               	add	x0, x0, x11
               	mov	w5, w5
               	mov	w23, w0
               	eor	x5, x5, x23
               	ror	w5, w5, #0x10
               	add	x6, x6, x5
               	mov	w11, w11
               	mov	w23, w6
               	eor	x11, x11, x23
               	ror	w11, w11, #0x14
               	add	x0, x0, x11
               	mov	w5, w5
               	mov	w23, w0
               	eor	x5, x5, x23
               	ror	w5, w5, #0x18
               	add	x6, x6, x5
               	mov	w11, w11
               	mov	w23, w6
               	eor	x11, x11, x23
               	ror	w11, w11, #0x19
               	add	x15, x15, x10
               	mov	w4, w4
               	mov	w23, w15
               	eor	x4, x4, x23
               	ror	w4, w4, #0x10
               	add	x9, x9, x4
               	mov	w10, w10
               	mov	w23, w9
               	eor	x10, x10, x23
               	ror	w10, w10, #0x14
               	add	x15, x15, x10
               	mov	w4, w4
               	mov	w23, w15
               	eor	x4, x4, x23
               	ror	w4, w4, #0x18
               	add	x9, x9, x4
               	mov	w10, w10
               	mov	w23, w9
               	eor	x10, x10, x23
               	ror	w10, w10, #0x19
               	add	x14, x14, x13
               	mov	w3, w3
               	mov	w23, w14
               	eor	x3, x3, x23
               	ror	w3, w3, #0x10
               	add	x8, x8, x3
               	mov	w13, w13
               	mov	w23, w8
               	eor	x13, x13, x23
               	ror	w13, w13, #0x14
               	add	x14, x14, x13
               	mov	w3, w3
               	mov	w23, w14
               	eor	x3, x3, x23
               	ror	w3, w3, #0x18
               	add	x8, x8, x3
               	mov	w13, w13
               	mov	w23, w8
               	eor	x13, x13, x23
               	ror	w13, w13, #0x19
               	add	x20, x20, #0x1
               	cmp	w20, #0xa
               	b.lt	<addr>
               	ldr	w20, [x21]
               	add	x1, x1, x20
               	str	w1, [x22]
               	ldr	w1, [x21, #0x4]
               	add	x0, x0, x1
               	str	w0, [x22, #0x4]
               	ldr	w0, [x21, #0x8]
               	add	x0, x15, x0
               	str	w0, [x22, #0x8]
               	ldr	w0, [x21, #0xc]
               	add	x0, x14, x0
               	str	w0, [x22, #0xc]
               	ldr	w0, [x21, #0x10]
               	add	x0, x13, x0
               	str	w0, [x22, #0x10]
               	ldr	w0, [x21, #0x14]
               	add	x0, x12, x0
               	str	w0, [x22, #0x14]
               	ldr	w0, [x21, #0x18]
               	add	x0, x11, x0
               	str	w0, [x22, #0x18]
               	ldr	w0, [x21, #0x1c]
               	add	x0, x10, x0
               	str	w0, [x22, #0x1c]
               	ldr	w0, [x21, #0x20]
               	add	x0, x9, x0
               	str	w0, [x22, #0x20]
               	ldr	w0, [x21, #0x24]
               	add	x0, x8, x0
               	str	w0, [x22, #0x24]
               	ldr	w0, [x21, #0x28]
               	add	x0, x7, x0
               	str	w0, [x22, #0x28]
               	ldr	w0, [x21, #0x2c]
               	add	x0, x6, x0
               	str	w0, [x22, #0x2c]
               	ldr	w0, [x21, #0x30]
               	add	x0, x5, x0
               	str	w0, [x22, #0x30]
               	ldr	w0, [x21, #0x34]
               	add	x0, x4, x0
               	str	w0, [x22, #0x34]
               	ldr	w0, [x21, #0x38]
               	add	x0, x3, x0
               	str	w0, [x22, #0x38]
               	ldr	w0, [x21, #0x3c]
               	add	x0, x2, x0
               	str	w0, [x22, #0x3c]
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldur	w1, [x29, #-0x40]
               	mov	x17, #0xf110            // =61712
               	movk	x17, #0xe4e7, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	ldur	w2, [x29, #-0x3c]
               	mov	x17, #0x3bd1            // =15313
               	movk	x17, #0x1559, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x2                // =2
               	ldur	w2, [x29, #-0x38]
               	mov	x17, #0xf50             // =3920
               	movk	x17, #0x1fdd, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	ldur	w2, [x29, #-0x34]
               	mov	x17, #0x20a3            // =8355
               	movk	x17, #0xc471, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x4                // =4
               	ldur	w2, [x29, #-0x30]
               	mov	x17, #0xd1c7            // =53703
               	movk	x17, #0xc7f4, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x5                // =5
               	ldur	w2, [x29, #-0x2c]
               	mov	x17, #0xc033            // =49203
               	movk	x17, #0x368, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x6                // =6
               	ldur	w2, [x29, #-0x28]
               	mov	x17, #0x2204            // =8708
               	movk	x17, #0x9aaa, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x7                // =7
               	ldur	w2, [x29, #-0x24]
               	mov	x17, #0xd4c3            // =54467
               	movk	x17, #0x4e6c, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x8                // =8
               	ldur	w2, [x29, #-0x20]
               	mov	x17, #0x82d2            // =33490
               	movk	x17, #0x4664, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0x9                // =9
               	ldur	w2, [x29, #-0x1c]
               	mov	x17, #0x9f07            // =40711
               	movk	x17, #0x9aa, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xa                // =10
               	ldur	w2, [x29, #-0x18]
               	mov	x17, #0xc214            // =49684
               	movk	x17, #0x5d7, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xb                // =11
               	ldur	w2, [x29, #-0x14]
               	mov	x17, #0x8bd9            // =35801
               	movk	x17, #0xa202, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xc                // =12
               	ldur	w2, [x29, #-0x10]
               	mov	x17, #0x12b5            // =4789
               	movk	x17, #0xd19c, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xd                // =13
               	ldur	w2, [x29, #-0xc]
               	mov	x17, #0x16de            // =5854
               	movk	x17, #0xb94e, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xe                // =14
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0xd0cb            // =53451
               	movk	x17, #0xe883, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x1, #0xf                // =15
               	ldur	w2, [x29, #-0x4]
               	mov	x17, #0x50a2            // =20642
               	movk	x17, #0x4e3c, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, x1
               	b	<addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
