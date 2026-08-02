
builtin_mem_transfer_inline.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x330              // =816
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<put_u32>:
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x1, [x29, #0x20]
               	add	x1, x29, #0x20
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
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<get_u32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x8
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
               	mov	x0, x1
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4a0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x0, x29, #0x448
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x448
               	ldr	w0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x448
               	ldrb	w0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x448
               	mov	x21, #0xcdef            // =52719
               	movk	x21, #0x89ab, lsl #16
               	movk	x21, #0x4567, lsl #32
               	movk	x21, #0x123, lsl #48
               	str	x21, [x0]
               	sub	x0, x29, #0x448
               	mov	x22, #0x3210            // =12816
               	movk	x22, #0x7654, lsl #16
               	movk	x22, #0xba98, lsl #32
               	movk	x22, #0xfedc, lsl #48
               	str	x22, [x0, #0x8]
               	sub	x0, x29, #0x448
               	mov	x1, #0xbeef             // =48879
               	movk	x1, #0xdead, lsl #16
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x448
               	mov	x1, #0x5a               // =90
               	strb	w1, [x0, #0x14]
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x448
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x460
               	ldr	x0, [x0]
               	cmp	x0, x21
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x460
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x22
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x460
               	ldr	w0, [x0, #0x10]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x460
               	ldrb	w0, [x0, #0x14]
               	cmp	x0, #0x5a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	mov	x1, #0x3345             // =13125
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xf
               	mov	x1, #0x3346             // =13126
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x16
               	mov	x1, #0x3347             // =13127
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1d
               	mov	x1, #0x3348             // =13128
               	movk	x1, #0x1122, lsl #16
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x7               // =7
               	mul	x0, x20, x17
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	bl	<addr>
               	sxtw	x1, w20
               	mov	w1, w1
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	add	x1, x1, x17
               	mov	w1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x460
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
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x5a              // =90
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x430
               	add	x0, x0, #0x0
               	mov	x1, #0x100              // =256
               	str	x1, [x0]
               	sub	x0, x29, #0x430
               	mov	x1, #0x101              // =257
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x430
               	mov	x1, #0x102              // =258
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x430
               	mov	x1, #0x103              // =259
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x430
               	mov	x1, #0x104              // =260
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x430
               	mov	x1, #0x105              // =261
               	str	x1, [x0, #0x28]
               	sub	x1, x29, #0x430
               	sub	x2, x29, #0x430
               	mov	x0, #0x0                // =0
               	ldr	x3, [x2]
               	ldr	x4, [x2, #0x8]
               	ldr	x2, [x2, #0x10]
               	str	x3, [x1, #0x8]
               	str	x4, [x1, #0x10]
               	str	x2, [x1, #0x18]
               	b	<addr>
               	sub	x2, x29, #0x430
               	add	x3, x1, #0x1
               	sxtw	x3, w3
               	ldr	x2, [x2, x3, lsl #3]
               	add	x3, x1, #0x100
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x430
               	add	x0, x0, #0x0
               	mov	x1, #0x100              // =256
               	str	x1, [x0]
               	sub	x0, x29, #0x430
               	mov	x1, #0x101              // =257
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x430
               	mov	x1, #0x102              // =258
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x430
               	mov	x1, #0x103              // =259
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x430
               	mov	x1, #0x104              // =260
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x430
               	mov	x1, #0x105              // =261
               	str	x1, [x0, #0x28]
               	sub	x2, x29, #0x430
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x430
               	ldr	x3, [x1, #0x8]
               	ldr	x4, [x1, #0x10]
               	ldr	x1, [x1, #0x18]
               	str	x3, [x2]
               	str	x4, [x2, #0x8]
               	str	x1, [x2, #0x10]
               	b	<addr>
               	sub	x2, x29, #0x430
               	ldr	x2, [x2, x1, lsl #3]
               	add	x3, x1, #0x101
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x18
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x4
               	mov	x20, #0x0               // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x0, #0x4
               	sxtw	x1, w1
               	add	x1, x2, x1
               	ldrb	w1, [x1]
               	eor	x1, x1, x0
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x18
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
               	add	x1, x1, x0
               	ldrb	w2, [x1]
               	add	x1, x0, #0x4
               	sxtw	x1, w1
               	eor	x1, x2, x1
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x200
               	add	x3, x2, x1
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x200
               	b.lt	<addr>
               	sub	x0, x29, #0x400
               	sub	x1, x29, #0x200
               	mov	x2, #0x200              // =512
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x400
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x200
               	b.lt	<addr>
               	mov	x2, #0x18               // =24
               	sub	x0, x29, #0x400
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	b	<addr>
               	sub	x0, x29, #0x400
               	add	x0, x0, x20
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	x20, #0x18
               	b.lo	<addr>
               	sub	x0, x29, #0x400
               	ldrb	w0, [x0, #0x18]
               	cmp	x0, #0x48
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x460
               	sub	x1, x29, #0x448
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x460
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x460
               	str	x21, [x0]
               	str	x22, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
