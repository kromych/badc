
float_is_four_bytes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x2, x1, #0x4
               	sub	x1, x2, x1
               	cmp	x1, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	adrp	x1, <page>
               	ldr	s0, [x1, #0x18]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x1, #0x18]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1, #0x4]
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x1, #0x4]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x8                // =8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1, #0x8]
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x1, #0x8]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x9                // =9
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1, #0xc]
               	fmov	s1, #4.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x1, #0xc]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0xa                // =10
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x10
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w1, [x29, #-0x8]
               	eor	x1, x1, #0x3f800000
               	cbz	w1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
