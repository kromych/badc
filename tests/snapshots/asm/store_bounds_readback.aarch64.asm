
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
               	ldrsw	x1, [x0]
               	and	x1, x1, #0x1ff
               	stur	w1, [x29, #-0x18]
               	ldrsw	x1, [x0]
               	and	x1, x1, #0x1ff
               	sxtb	x2, w1
               	cmp	w2, #0x0
               	cset	x3, lt
               	mov	x17, #-0x38             // =-56
               	cmp	w2, w17
               	cset	x1, eq
               	lsl	x1, x1, #1
               	add	x1, x3, x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	ldrsw	x1, [x0]
               	and	x1, x1, #0x1ff
               	and	x1, x1, #0xff
               	mov	x17, #0xc8              // =200
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, eq
               	lsl	x1, x1, #1
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	ldrsw	x1, [x0]
               	and	x1, x1, #0x1ff
               	mov	x17, #0xc8              // =200
               	mul	x1, x1, x17
               	sxth	x2, w1
               	cmp	w2, #0x0
               	cset	x3, lt
               	mov	x17, #-0x63c0           // =-25536
               	cmp	w2, w17
               	cset	x1, eq
               	lsl	x1, x1, #1
               	add	x1, x3, x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	ldrsw	x0, [x0]
               	and	x0, x0, #0x1ff
               	and	x0, x0, #0x7
               	mov	x17, #-0x1              // =-1
               	mul	x0, x0, x17
               	sub	x0, x0, #0x1
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	cset	x1, hi
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x1, x0
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
               	mov	x1, #-0x7               // =-7
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x0
               	cset	x1, lt
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x1, x0
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
               	mov	x1, #-0x3               // =-3
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x0
               	cset	x1, lt
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	cset	x0, eq
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x40
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	orr	x20, x20, #0x80
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
