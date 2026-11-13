
stepped_pointer_accesses.aarch64:	file format elf64-littleaarch64

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

<sum_u8>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldrb	w3, [x0], #0x1
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_u8_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldrb	w3, [x2, x3]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_i8>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldrsb	x3, [x0], #0x1
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_i8_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldrsb	x3, [x2, x3]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_u16>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldrh	w3, [x0], #0x2
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_u16_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldrh	w3, [x2, x3, lsl #1]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_i16>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldrsh	x3, [x0], #0x2
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_i16_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldrsh	x3, [x2, x3, lsl #1]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_u32>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldr	w3, [x0], #0x4
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_u32_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldr	w3, [x2, x3, lsl #2]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_i32>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldrsw	x3, [x0], #0x4
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_i32_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_u64>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #1
               	ldr	x3, [x0], #0x8
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<sum_u64_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	add	x0, x0, x0, lsl #1
               	ldur	x3, [x29, #-0x8]
               	ldr	x3, [x2, x3, lsl #3]
               	add	x0, x0, x3
               	ldur	x3, [x29, #-0x8]
               	add	x3, x3, #0x1
               	stur	x3, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, x1
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<dot>:
               	movi	d0, #0000000000000000
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	ldr	d1, [x0], #0x8
               	ldr	s2, [x1], #0x4
               	fcvt	d2, s2
               	fmadd	d0, d1, d2, d0
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	ret

<dot_ref>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	stur	xzr, [x29, #-0x8]
               	movi	d0, #0000000000000000
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x3, x0, lsl #3
               	ldr	d1, [x0]
               	ldur	x0, [x29, #-0x8]
               	add	x0, x1, x0, lsl #2
               	ldr	s2, [x0]
               	fcvt	d2, s2
               	fmadd	d0, d1, d2, d0
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, x2
               	b.lt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<fill>:
               	mov	x4, #0x7                // =7
               	subs	x2, x2, #0x1
               	b.lo	<addr>
               	add	x0, x0, #0x2
               	and	x5, x3, #0xffff
               	sturh	w5, [x0, #-0x2]
               	str	w3, [x1], #0x4
               	mul	x3, x3, x4
               	add	x3, x3, #0x1
               	subs	x2, x2, #0x1
               	b.hs	<addr>
               	ret

<clear>:
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	strh	wzr, [x0], #0x2
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	ret

<cut>:
               	ldrh	w1, [x0]
               	cbz	x1, <addr>
               	strh	wzr, [x0], #0x2
               	ret

<reverse>:
               	add	x2, x1, x2
               	cmp	x2, x1
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	sub	x2, x2, #0x1
               	ldrb	w3, [x2]
               	sturb	w3, [x0, #-0x1]
               	cmp	x2, x1
               	b.ne	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	str	d8, [sp]
               	stp	x20, x21, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7c15             // =31765
               	movk	x2, #0x7f4a, lsl #16
               	movk	x2, #0x79b9, lsl #32
               	movk	x2, #0x9e37, lsl #48
               	mov	x3, #0x25               // =37
               	mov	x4, #0x1003             // =4099
               	mov	x5, #0x9c40             // =40000
               	mov	x6, #0x79b9             // =31161
               	movk	x6, #0x9e37, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	adrp	x12, <page>
               	add	x12, x12, <lo12>
               	mul	x1, x0, x3
               	add	x1, x1, #0xc8
               	and	x1, x1, #0xff
               	strb	w1, [x7, x0]
               	mul	x1, x0, x4
               	add	x1, x1, x5
               	and	x1, x1, #0xffff
               	strh	w1, [x8, x0, lsl #1]
               	add	x1, x0, #0x1
               	mul	x13, x1, x6
               	str	w13, [x9, x0, lsl #2]
               	add	x13, x0, #0x3
               	mul	x13, x13, x2
               	str	x13, [x10, x0, lsl #3]
               	add	x13, x11, x0, lsl #3
               	scvtf	d0, x0
               	fmov	d1, #0.25000000
               	fmov	d2, #3.00000000
               	fnmsub	d1, d0, d1, d2
               	str	d1, [x13]
               	add	x0, x12, x0, lsl #2
               	fmov	d1, #1.50000000
               	fmov	d2, #20.00000000
               	fnmsub	d0, d0, d1, d2
               	fcvt	s0, d0
               	str	s0, [x0]
               	mov	x0, x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	fmov	d8, d0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	fcmp	d8, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0xf0
               	sub	x21, x29, #0xa0
               	mov	x2, #0x28               // =40
               	mov	x3, #0x5                // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7                // =7
               	ldrh	w3, [x20, x0, lsl #1]
               	and	x4, x1, #0xffff
               	cmp	w3, w4
               	b.ne	<addr>
               	ldr	w3, [x21, x0, lsl #2]
               	cmp	w3, w1
               	b.ne	<addr>
               	mul	x1, x1, x2
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x0, x29, #0x150
               	mov	x1, #0x8000             // =32768
               	movk	x1, #0x8001, lsl #16
               	str	w1, [sp, #0x20]
               	mov	x1, #0x8002             // =32770
               	movk	x1, #0x8003, lsl #16
               	str	w1, [sp, #0x24]
               	mov	x1, #0x8004             // =32772
               	movk	x1, #0x8005, lsl #16
               	str	w1, [sp, #0x28]
               	mov	x1, #0x8006             // =32774
               	movk	x1, #0x8007, lsl #16
               	str	w1, [sp, #0x2c]
               	mov	x1, #0x8008             // =32776
               	movk	x1, #0x8009, lsl #16
               	str	w1, [sp, #0x30]
               	mov	x1, #0x800a             // =32778
               	movk	x1, #0x800b, lsl #16
               	str	w1, [sp, #0x34]
               	add	x0, x0, #0x2
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x150
               	ldrh	w1, [sp, #0x22]
               	cbz	w1, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrh	w1, [sp, #0x24]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x26]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x28]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x2a]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x2c]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x2e]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x30]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x32]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x34]
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x20]
               	eor	x1, x1, #0x8000
               	cbnz	w1, <addr>
               	ldrh	w1, [sp, #0x36]
               	mov	x17, #0x800b            // =32779
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	strh	w1, [sp, #0x26]
               	add	x0, x0, #0x6
               	bl	<addr>
               	sub	x1, x29, #0x150
               	add	x2, x1, #0x8
               	cmp	x0, x2
               	b.ne	<addr>
               	ldrh	w0, [sp, #0x26]
               	cbnz	w0, <addr>
               	add	x0, x1, #0x6
               	bl	<addr>
               	sub	x1, x29, #0x150
               	add	x1, x1, #0x6
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x118
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x20, #0x10]
               	ldrb	w16, [x0, #0x20]
               	strb	w16, [x20, #0x20]
               	sub	x21, x29, #0x138
               	mov	x2, #0x20               // =32
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x21, x0]
               	mov	x2, #0x1f               // =31
               	sub	x2, x2, x0
               	ldrb	w2, [x20, x2]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
