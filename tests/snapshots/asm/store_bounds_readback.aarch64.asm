
store_bounds_readback.aarch64:	file format elf64-littleaarch64

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

<touch_int>:
               	ret

<touch_box>:
               	ret

<write_int>:
               	str	w1, [x0]
               	ret

<volatile_object>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x0
               	cset	x1, ge
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x1ff
               	cset	x0, le
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x28
               	bl	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	sxtb	x1, w0
               	cmp	w1, #0x0
               	cset	x2, lt
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w1, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x2, x0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	and	x0, x0, #0xff
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	and	x1, x1, #0x1ff
               	mov	x17, #0xc8              // =200
               	mul	x1, x1, x17
               	sxth	x0, w1
               	cmp	w0, #0x0
               	cset	x2, lt
               	mov	x17, #0x9c40            // =40000
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x2, x0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	and	x0, x0, #0x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	sub	x0, x0, #0x1
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	w1, w17
               	cset	x2, hi
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	w1, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x2, x0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x10
               	sub	x0, x29, #0x10
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	mov	x1, #0xfff9             // =65529
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x0
               	cset	x1, lt
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x20
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sub	x0, x29, #0x8
               	str	x0, [x21]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x8]
               	ldr	x0, [x21]
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x0
               	cset	x1, lt
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
