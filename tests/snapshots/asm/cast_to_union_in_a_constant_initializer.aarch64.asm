
cast_to_union_in_a_constant_initializer.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x20]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrb	w1, [x0, #0x30]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldr	x0, [x0, #0x30]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x38]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0]
               	cmp	w0, #0x67
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	ldrsw	x0, [x0, #0x90]
               	cmp	w0, #0xb
               	csel	x0, x1, x2, eq
               	ret
               	mov	x0, #0x2                // =2
               	ret
