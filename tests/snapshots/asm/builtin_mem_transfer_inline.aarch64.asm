
builtin_mem_transfer_inline.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x450
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	mov	x22, #0x0               // =0
               	mov	x21, #0xcdef            // =52719
               	movk	x21, #0x89ab, lsl #16
               	movk	x21, #0x4567, lsl #32
               	movk	x21, #0x123, lsl #48
               	mov	x23, #0x3210            // =12816
               	movk	x23, #0x7654, lsl #16
               	movk	x23, #0xba98, lsl #32
               	movk	x23, #0xfedc, lsl #48
               	mov	x24, #0xbeef            // =48879
               	movk	x24, #0xdead, lsl #16
               	mov	x25, #0x5a              // =90
               	sub	x0, x29, #0x418
               	str	x21, [x0]
               	str	x23, [x0, #0x8]
               	str	w24, [x0, #0x10]
               	strb	w25, [x0, #0x14]
               	strb	w22, [x0, #0x15]
               	strh	w22, [x0, #0x16]
               	cmp	x21, x21
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x23
               	b.ne	<addr>
               	ldr	w1, [x0, #0x10]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x14]
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x1, #0x1
               	mov	x0, #0x3344             // =13124
               	movk	x0, #0x1122, lsl #16
               	sub	x17, x29, #0x420
               	str	w0, [x17]
               	sub	x0, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x2]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x2, #0x3]
               	ldr	x10, [sp], #0x10
               	add	x3, x1, #0x8
               	mov	x4, #0x3345             // =13125
               	movk	x4, #0x1122, lsl #16
               	sub	x17, x29, #0x420
               	str	w4, [x17]
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x3]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x3, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x3, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x3, #0x3]
               	ldr	x10, [sp], #0x10
               	add	x4, x1, #0xf
               	mov	x5, #0x3346             // =13126
               	movk	x5, #0x1122, lsl #16
               	sub	x17, x29, #0x420
               	str	w5, [x17]
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x4]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x4, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x4, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x4, #0x3]
               	ldr	x10, [sp], #0x10
               	add	x4, x1, #0x16
               	mov	x5, #0x3347             // =13127
               	movk	x5, #0x1122, lsl #16
               	sub	x17, x29, #0x420
               	str	w5, [x17]
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x4]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x4, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x4, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x4, #0x3]
               	ldr	x10, [sp], #0x10
               	add	x1, x1, #0x1d
               	mov	x4, #0x3348             // =13128
               	movk	x4, #0x1122, lsl #16
               	sub	x17, x29, #0x420
               	str	w4, [x17]
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x1]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x0]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x420
               	ldr	w1, [x16]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x3]
               	strb	w10, [x0]
               	ldrb	w10, [x3, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x3, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x3, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x420
               	ldr	w0, [x16]
               	mov	x17, #0x3345            // =13125
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xf
               	sub	x1, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x420
               	ldr	w2, [x16]
               	mov	x17, #0x3346            // =13126
               	movk	x17, #0x1122, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	add	x2, x0, #0x16
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x420
               	ldr	w2, [x16]
               	mov	x17, #0x3347            // =13127
               	movk	x17, #0x1122, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	add	x2, x0, #0x1d
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x420
               	ldr	w1, [x16]
               	mov	x17, #0x3348            // =13128
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	sub	x1, x29, #0x418
               	ldrb	w1, [x1, #0x14]
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w1, [x0, #0xd]
               	strb	w1, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	ldrb	w1, [x0]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x5a              // =90
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w0, [x1, #0x8]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0x9]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xa]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xb]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xc]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xd]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xe]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x1, #0xf]
               	mov	x17, #0x5a              // =90
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x4]
               	cbz	w1, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, #0x2
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, #0x3
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, #0x4
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x9]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xa]
               	eor	x1, x1, #0x6
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xb]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xc]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xd]
               	mov	x17, #0x9               // =9
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xe]
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xf]
               	mov	x17, #0xb               // =11
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x10]
               	eor	x1, x1, #0xc
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x11]
               	mov	x17, #0xd               // =13
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x12]
               	eor	x0, x0, #0xe
               	cbnz	w0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w0, [x1, #0x13]
               	eor	x0, x0, #0xf
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x4
               	cbz	w1, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x2]
               	eor	x1, x1, #0x6
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x3]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x4]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x9               // =9
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0xb               // =11
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, #0xc
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x9]
               	mov	x17, #0xd               // =13
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xa]
               	eor	x1, x1, #0xe
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xb]
               	eor	x1, x1, #0xf
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xc]
               	eor	x1, x1, #0x10
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0xd]
               	mov	x17, #0x11              // =17
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xe]
               	mov	x17, #0x12              // =18
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x13              // =19
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0x400
               	mul	x3, x0, x1
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	sub	x1, x29, #0x400
               	mov	x2, #0x200              // =512
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0x200
               	ldrb	w2, [x2, x0]
               	mul	x3, x0, x1
               	and	x3, x3, #0xff
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x2, #0x18               // =24
               	sub	x0, x29, #0x200
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x200
               	ldrb	w0, [x0, x20]
               	cbnz	w0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x18
               	b.lo	<addr>
               	sub	x0, x29, #0x200
               	ldrb	w0, [x0, #0x18]
               	cmp	w0, #0x48
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x418
               	str	x21, [x0]
               	str	x23, [x0, #0x8]
               	str	w24, [x0, #0x10]
               	strb	w25, [x0, #0x14]
               	strb	w22, [x0, #0x15]
               	strh	w22, [x0, #0x16]
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x21, [x0]
               	str	x23, [x0, #0x8]
               	mov	x0, x1
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x450
               	ldp	x29, x30, [sp], #0x10
               	ret
