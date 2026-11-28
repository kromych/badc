
one_shape_at_two_widths_is_two_values.aarch64:	file format elf64-littleaarch64

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

<compare_twice>:
               	cmp	w0, w1
               	cset	x2, lt
               	cmp	x0, x1
               	cset	x0, lt
               	add	x0, x2, x0, lsl #1
               	ret

<compare_in_a_loop>:
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w3, w2
               	b.ge	<addr>
               	cmp	x0, x1
               	cset	x6, lt
               	str	w6, [x5, x3, lsl #2]
               	cmp	w0, w1
               	cset	x6, lt
               	str	w6, [x4, x3, lsl #2]
               	add	x3, x3, #0x1
               	cmp	w3, w2
               	b.lt	<addr>
               	ret

<convert_narrow_first>:
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	scvtf	s0, x0
               	scvtf	d1, x0
               	cmp	w2, w1
               	b.ge	<addr>
               	str	s0, [x4, x2, lsl #2]
               	str	d1, [x3, x2, lsl #3]
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<convert_wide_first>:
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	scvtf	d0, x0
               	scvtf	s1, x0
               	cmp	w2, w1
               	b.ge	<addr>
               	str	d0, [x3, x2, lsl #3]
               	str	s1, [x4, x2, lsl #2]
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<compare_per_element>:
               	cmp	w0, #0x5
               	cset	x2, lt
               	cmp	x0, #0x5
               	cset	x0, lt
               	str	w2, [x1]
               	str	w0, [x1, #0x4]
               	str	w2, [x1, #0x8]
               	str	w0, [x1, #0xc]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x1                // =1
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	lsl	x21, x1, x0
               	mov	x0, x21
               	bl	<addr>
               	cmp	w0, #0x1
               	mov	x16, #0x1               // =1
               	csel	x20, x16, xzr, ne
               	mov	x0, x21
               	mov	x1, #0x1                // =1
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cbz	w0, <addr>
               	orr	x20, x20, #0x2
               	asr	x0, x21, #8
               	add	x0, x0, #0x1
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x18]
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0xc]
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	lsl	x0, x21, #28
               	add	x0, x0, x21, lsl #4
               	add	x0, x0, #0x1
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x8]
               	orr	x1, x20, #0x8
               	ldr	s1, [x0, #0xc]
               	fcmp	s1, s0
               	csel	x20, x1, x20, ne
               	mov	x0, x21
               	sub	x1, x29, #0x10
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xc]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x4]
               	cbz	w0, <addr>
               	orr	x20, x20, #0x10
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
