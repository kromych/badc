
printf_sharp_flag_on_infinity_and_nan_keeps_width_sign_and_counts.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0xb
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0xb
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0xb
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0xb
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d0, s0
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldurb	w1, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	cmp	w1, #0x2d
               	cinc	x20, x0, eq
               	mov	x0, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	cbz	w0, <addr>
               	cmp	w0, #0x28
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d0, s0
               	fneg	d0, d0
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldurb	w1, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	cmp	w1, #0x2d
               	cinc	x20, x0, eq
               	mov	x0, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	cbz	w0, <addr>
               	cmp	w0, #0x28
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d0, s0
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldurb	w1, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	cmp	w1, #0x2d
               	cinc	x20, x0, eq
               	mov	x0, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	cbz	w0, <addr>
               	cmp	w0, #0x28
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	fcvt	d0, s0
               	fneg	d0, d0
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldurb	w1, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	cmp	w1, #0x2d
               	cinc	x20, x0, eq
               	mov	x0, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0x3]
               	cbz	w0, <addr>
               	cmp	w0, #0x28
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x140
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x19
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x3, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x140
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x140
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0xd
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x3, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x140
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d1, x16
               	sub	x0, x29, #0x140
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x7                // =7
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x9
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x3, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x140
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x2, x0
               	cmp	w2, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	stur	wzr, [x29, #-0x8]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x140
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x8
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x140
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	ldursw	x4, [x29, #-0x8]
               	mov	x3, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x140
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	fmov	d0, #1.50000000
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x3
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x40
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x4, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x100
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	sub	x0, x29, #0x100
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	cmp	w20, #0x7
               	b.eq	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	mov	x3, x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x100
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	ldr	x20, [sp]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
