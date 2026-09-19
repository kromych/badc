
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
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	fmov	s0, #1.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, #0x5               // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x4
               	sub	x1, x1, x0
               	cmp	x1, #0x4
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, #0x6               // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x20, #0x7               // =7
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
               	mov	x20, #0x8               // =8
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
               	mov	x20, #0x9               // =9
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
               	mov	x20, #0xa               // =10
               	fmov	s0, #1.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, #0xb               // =11
               	fmov	s0, #2.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, #0xc               // =12
               	fmov	s0, #1.50000000
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, #0xd               // =13
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.50000000
               	fadd	s0, s0, s1
               	fadd	s0, s0, s2
               	fmov	s1, #6.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x20, #0xe               // =14
               	fmov	s0, #1.50000000
               	fmov	s1, #2.00000000
               	fmov	s2, #0.25000000
               	fmadd	s0, s0, s1, s2
               	fmov	s1, #3.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x20, #0xf               // =15
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x8]
               	eor	x0, x0, #0x3f800000
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
