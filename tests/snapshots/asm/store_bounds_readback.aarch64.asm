
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
               	ldrsw	x0, [x0, #0xc]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x0
               	cset	x0, ge
               	ldursw	x1, [x29, #-0x8]
               	cmp	w1, #0x1ff
               	cset	x1, le
               	add	x0, x0, x1, lsl #1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x10
               	bl	<addr>
               	sub	x0, x29, #0x18
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xc]
               	and	x1, x1, #0x1ff
               	stur	w1, [x29, #-0x18]
               	ldrsw	x1, [x0, #0xc]
               	and	x1, x1, #0x1ff
               	sxtb	x1, w1
               	cmp	w1, #0x0
               	cset	x2, lt
               	cmn	w1, #0x38
               	cset	x1, eq
               	add	x1, x2, x1, lsl #1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	cmp	w1, #0x3
               	csel	x1, x2, x3, ne
               	ldrsw	x2, [x0, #0xc]
               	and	x2, x2, #0x1ff
               	and	x2, x2, #0xff
               	cmp	w2, #0xc8
               	cset	x2, eq
               	lsl	x2, x2, #1
               	add	x2, x2, #0x1
               	orr	x3, x1, #0x4
               	cmp	w2, #0x3
               	csel	x1, x3, x1, ne
               	ldrsw	x2, [x0, #0xc]
               	and	x2, x2, #0x1ff
               	mov	x17, #0xc8              // =200
               	mul	x2, x2, x17
               	sxth	x2, w2
               	cmp	w2, #0x0
               	cset	x3, lt
               	mov	x17, #-0x63c0           // =-25536
               	cmp	w2, w17
               	cset	x2, eq
               	add	x2, x3, x2, lsl #1
               	orr	x3, x1, #0x8
               	cmp	w2, #0x3
               	csel	x1, x3, x1, ne
               	ldrsw	x0, [x0, #0xc]
               	and	x0, x0, #0x1ff
               	and	x0, x0, #0x7
               	mvn	x0, x0
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	cset	x2, hi
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	cset	x0, eq
               	add	x0, x2, x0, lsl #1
               	orr	x2, x1, #0x10
               	cmp	w0, #0x3
               	csel	x20, x2, x1, ne
               	sub	x0, x29, #0x18
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x18]
               	sub	x0, x29, #0x18
               	mov	x1, #-0x7               // =-7
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x0
               	cset	x1, lt
               	cmn	w0, #0x7
               	cset	x0, eq
               	add	x0, x1, x0, lsl #1
               	orr	x1, x20, #0x20
               	cmp	w0, #0x3
               	csel	x20, x1, x20, ne
               	adrp	x1, <page>
               	sub	x0, x29, #0x18
               	str	x0, [x1, #0x20]
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc]
               	and	x0, x0, #0x1ff
               	stur	w0, [x29, #-0x18]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #-0x3               // =-3
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x0
               	cset	x1, lt
               	cmn	w0, #0x3
               	cset	x0, eq
               	add	x0, x1, x0, lsl #1
               	orr	x1, x20, #0x40
               	cmp	w0, #0x3
               	csel	x20, x1, x20, ne
               	bl	<addr>
               	orr	x1, x20, #0x80
               	cmp	w0, #0x3
               	csel	x0, x1, x20, ne
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
