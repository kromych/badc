
volatile_param_classes.aarch64:	file format elf64-littleaarch64

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

<half>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	fcvt	d0, s0
               	fmov	d1, #0.50000000
               	fmul	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	fmov	d0, #1.50000000
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	stur	d0, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	fmov	d0, #2.50000000
               	ldr	x2, [x0, #0x8]
               	add	x2, x2, #0x1
               	str	x2, [x0, #0x8]
               	stur	d0, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	fmov	d0, #3.50000000
               	ldr	x2, [x0, #0x8]
               	add	x2, x2, #0x1
               	str	x2, [x0, #0x8]
               	stur	d0, [x29, #-0x18]
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	ldr	d0, [x0]
               	fmov	d1, #7.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #5.00000000
               	bl	<addr>
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
