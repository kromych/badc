
float_condition_negative_zero.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	mov	x0, #0x1                // =1
               	fmov	d17, x1
               	fcmp	d0, d17
               	csel	x0, x0, x1, ne
               	fmov	d16, x1
               	fcmp	d16, d0
               	cset	x2, eq
               	orr	x3, x0, #0x2
               	cmp	x2, #0x0
               	csel	x3, x3, x0, eq
               	mov	x0, x1
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.gt	<addr>
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	orr	x1, x3, #0x4
               	cmp	w0, #0x0
               	csel	x0, x1, x3, ne
               	movi	d1, #0000000000000000
               	orr	x1, x0, #0x8
               	fcmp	d0, d1
               	csel	x0, x1, x0, ne
               	orr	x1, x0, #0x10
               	fcmp	d0, d1
               	csel	x0, x1, x0, ne
               	orr	x1, x0, #0x20
               	fcmp	d0, d1
               	csel	x0, x1, x0, ne
               	orr	x1, x0, #0x40
               	fcmp	d0, d1
               	csel	x1, x1, x0, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
