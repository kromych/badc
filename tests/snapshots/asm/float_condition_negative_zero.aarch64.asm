
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
               	mov	x2, #0x0                // =0
               	fmov	d16, x2
               	fneg	d0, d16
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	fmov	d16, x2
               	fcmp	d16, d0
               	b.eq	<addr>
               	orr	x1, x1, #0x2
               	mov	x0, x2
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.gt	<addr>
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	cbz	w0, <addr>
               	orr	x1, x1, #0x4
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x1, x1, #0x8
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x1, x1, #0x10
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x1, x1, #0x20
               	fcmp	d0, d1
               	b.ne	<addr>
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
               	orr	x1, x1, #0x40
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
