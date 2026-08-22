
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
               	sub	sp, sp, #0x490
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x0, x29, #0x448
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	mov	x2, x1
               	mov	x2, x1
               	mov	x22, #0xcdef            // =52719
               	movk	x22, #0x89ab, lsl #16
               	movk	x22, #0x4567, lsl #32
               	movk	x22, #0x123, lsl #48
               	str	x22, [x0]
               	mov	x23, #0x3210            // =12816
               	movk	x23, #0x7654, lsl #16
               	movk	x23, #0xba98, lsl #32
               	movk	x23, #0xfedc, lsl #48
               	str	x23, [x0, #0x8]
               	mov	x1, #0xbeef             // =48879
               	movk	x1, #0xdead, lsl #16
               	str	w1, [x0, #0x10]
               	mov	x1, #0x5a               // =90
               	strb	w1, [x0, #0x14]
               	sub	x1, x29, #0x418
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldr	x0, [x1]
               	cmp	x0, x22
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	x3, [x1, #0x8]
               	cmp	x3, x23
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	w0, [x1, #0x10]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	w0, w17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x14]
               	cmp	w0, #0x5a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	sub	x17, x29, #0x450
               	str	x1, [x17]
               	sub	x2, x29, #0x450
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x1, #0x3345             // =13125
               	movk	x1, #0x1122, lsl #16
               	sub	x17, x29, #0x450
               	str	x1, [x17]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xf
               	mov	x1, #0x3346             // =13126
               	movk	x1, #0x1122, lsl #16
               	sub	x17, x29, #0x450
               	str	x1, [x17]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x16
               	mov	x1, #0x3347             // =13127
               	movk	x1, #0x1122, lsl #16
               	sub	x17, x29, #0x450
               	str	x1, [x17]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1d
               	mov	x1, #0x3348             // =13128
               	movk	x1, #0x1122, lsl #16
               	sub	x17, x29, #0x450
               	str	x1, [x17]
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x17, #0x7               // =7
               	mul	x1, x0, x17
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	add	x1, x3, x1
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x2]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x2, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x16, x29, #0x450
               	ldr	w3, [x16]
               	mov	w1, w0
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	add	x1, x1, x17
               	mov	w1, w1
               	cmp	w3, w1
               	b.ne	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x5a              // =90
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x430
               	add	x0, x1, #0x0
               	mov	x2, #0x100              // =256
               	str	x2, [x0]
               	mov	x0, #0x101              // =257
               	str	x0, [x1, #0x8]
               	mov	x0, #0x102              // =258
               	str	x0, [x1, #0x10]
               	mov	x0, #0x103              // =259
               	str	x0, [x1, #0x18]
               	mov	x0, #0x104              // =260
               	str	x0, [x1, #0x20]
               	mov	x0, #0x105              // =261
               	str	x0, [x1, #0x28]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	ldr	x4, [x1, #0x10]
               	str	x2, [x1, #0x8]
               	str	x3, [x1, #0x10]
               	str	x4, [x1, #0x18]
               	b	<addr>
               	sxtw	x2, w0
               	add	x3, x2, #0x1
               	sxtw	x3, w3
               	ldr	x3, [x1, x3, lsl #3]
               	add	x4, x2, #0x100
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x430
               	add	x0, x1, #0x0
               	mov	x2, #0x100              // =256
               	str	x2, [x0]
               	mov	x0, #0x101              // =257
               	str	x0, [x1, #0x8]
               	mov	x0, #0x102              // =258
               	str	x0, [x1, #0x10]
               	mov	x0, #0x103              // =259
               	str	x0, [x1, #0x18]
               	mov	x0, #0x104              // =260
               	str	x0, [x1, #0x20]
               	mov	x0, #0x105              // =261
               	str	x0, [x1, #0x28]
               	mov	x0, #0x0                // =0
               	ldr	x2, [x1, #0x8]
               	ldr	x3, [x1, #0x10]
               	ldr	x4, [x1, #0x18]
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	str	x4, [x1, #0x10]
               	b	<addr>
               	sxtw	x2, w0
               	ldr	x3, [x1, x2, lsl #3]
               	add	x4, x2, #0x101
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x4
               	mov	x20, #0x0               // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x20, #0x4
               	sxtw	x0, w0
               	add	x0, x1, x0
               	ldrb	w0, [x0]
               	eor	x0, x0, x20
               	mov	w0, w0
               	cbnz	x0, <addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	add	x1, x0, #0x4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w20
               	add	x1, x1, x0
               	ldrb	w2, [x1]
               	add	x1, x0, #0x4
               	eor	x1, x2, x1
               	mov	w1, w1
               	cbnz	x1, <addr>
               	add	x20, x0, #0x1
               	cmp	w20, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x400
               	sxtw	x1, w0
               	add	x3, x2, x1
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	sub	x20, x29, #0x200
               	sub	x1, x29, #0x400
               	mov	x2, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w3, [x2]
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x2, #0x18               // =24
               	sub	x21, x29, #0x200
               	mov	x20, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	b	<addr>
               	add	x0, x21, x20
               	ldrb	w0, [x0]
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	x20, #0x18
               	b.lo	<addr>
               	sub	x0, x29, #0x200
               	ldrb	w0, [x0, #0x18]
               	cmp	w0, #0x48
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x418
               	sub	x1, x29, #0x448
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x22, [x0]
               	str	x23, [x0, #0x8]
               	mov	x0, x1
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x490
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
